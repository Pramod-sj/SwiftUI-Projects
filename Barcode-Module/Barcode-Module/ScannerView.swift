//
//  ScannerView.swift
//  Barcode-Module
//
//  Created by Pramod Singh on 08/01/24.
//

import SwiftUI


struct ScannerView : UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> ScannerVC {
        ScannerVC(delegate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: ScannerVC, context: Context) {}
    
    func makeCoordinator() -> Coordinator { Coordinator() }
    
    final class Coordinator : NSObject, ScannerVCDelegate {
        
        func didFind(code: String) {
            print(code)
        }
        
        func didSurface(error: ScannerVCError) {
            print(error.rawValue)
        }
        
    }
        
}
