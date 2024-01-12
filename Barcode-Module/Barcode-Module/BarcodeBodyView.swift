//
//  BarcodeBodyView.swift
//  Barcode-Module
//
//  Created by Pramod Singh on 08/01/24.
//

import SwiftUI

#Preview {
    BarcodeBodyView()
}


public struct BarcodeBodyView: View {
    
    public init(){}
    
    public var body: some View {
        NavigationView{
            VStack {
                
                ScannerView()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: 300)
                
                Spacer().frame(height: 40)
                
                Label("Barcode Scanned", systemImage: "barcode.viewfinder")
                    .font(.title2)
                
                Text("PRADSJFDJDS")
                    .foregroundColor(.green)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .bold()
                    .padding()
                
            }.navigationTitle("Barcode Scanner")
        }
    }
    
}
