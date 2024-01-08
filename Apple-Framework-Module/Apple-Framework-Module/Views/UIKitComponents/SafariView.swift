//
//  SafariView.swift
//  Apple-Framework-Module
//
//  Created by Pramod Singh on 08/01/24.
//

import SwiftUI
import SafariServices


//Interoperability between UIViewController and SwiftUI View
struct SafariView : UIViewControllerRepresentable{
    
    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController  {
        SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
        
    }
    
}
