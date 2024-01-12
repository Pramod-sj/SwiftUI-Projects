//
//  ScannerVC.swift
//  Barcode-Module
//
//  Created by Pramod Singh on 08/01/24.
//

import UIKit
import AVFoundation

protocol ScannerVCDelegate : AnyObject {
    
    func didFind(code: String)
    
    func didSurface(error: ScannerVCError)
    
}

enum ScannerVCError : String {
    
    case invalidDeviceInput = "Invalid device input!!!"
    
    case invalidBarCode = "Invalid bar code"
    
}


final class ScannerVC : UIViewController {
    
    
    let captureSession = AVCaptureSession()
    
    var previewLayer: AVCaptureVideoPreviewLayer? = nil

    weak var scannerVCProtocal: (ScannerVCDelegate)?
    
    init(delegate: ScannerVCDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.scannerVCProtocal = delegate
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented")}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let previewLayer = previewLayer else {
            scannerVCProtocal?.didSurface(error: .invalidDeviceInput)
            return
        }
        previewLayer.frame = view.layer.bounds
    }
    
    
    private func setupCaptureSession(){
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { scannerVCProtocal?.didSurface(error: ScannerVCError.invalidDeviceInput)
            return
        }
        
        let input : AVCaptureDeviceInput
        
        do{
            try input = AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            scannerVCProtocal?.didSurface(error: ScannerVCError.invalidDeviceInput)
            return
        }
        
        if(captureSession.canAddInput(input)){
            captureSession.addInput(input)
        } else {
            scannerVCProtocal?.didSurface(error: ScannerVCError.invalidDeviceInput)
            return
        }
        
        let metaDataOutput = AVCaptureMetadataOutput()
        
        if(captureSession.canAddOutput(metaDataOutput)){
            captureSession.addOutput(metaDataOutput)
            metaDataOutput.setMetadataObjectsDelegate(self, queue: .main)
            metaDataOutput.metadataObjectTypes = [.ean8,.ean13]
        } else {
            scannerVCProtocal?.didSurface(error: ScannerVCError.invalidDeviceInput)
            return
        }
            
        previewLayer = AVCaptureVideoPreviewLayer()
        previewLayer!.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer!)
        
        captureSession.startRunning()
    }
}


extension ScannerVC : AVCaptureMetadataOutputObjectsDelegate { 
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
    
        guard let metaObject = metadataObjects.first else { 
            scannerVCProtocal?.didSurface(error: ScannerVCError.invalidBarCode)
            return }
        
        guard let machineReadableObj = metaObject as? AVMetadataMachineReadableCodeObject else {
            scannerVCProtocal?.didSurface(error: ScannerVCError.invalidBarCode)
            return
        }
        
        guard let barcodeString = machineReadableObj.stringValue else { return }
        
        scannerVCProtocal?.didFind(code: barcodeString)
    
    }
    
}
