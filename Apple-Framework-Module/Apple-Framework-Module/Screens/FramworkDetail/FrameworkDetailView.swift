//
//  FrameworkDetailModal.swift
//  Apple-Framework-Module
//
//  Created by Pramod Singh on 07/01/24.
//

import SwiftUI
import Foundation


#Preview {
    FrameworkDetailView(
        isModal: true,
        framework: MockData.sampleFramework){}
}

struct FrameworkDetailView : View {
    
    let isModal: Bool
    
    let framework: Framework
    
    let closeCallbak: () -> Void
    
    init(isModal: Bool = true, framework: Framework, closeCallbak: @escaping () -> Void = {}) {
        self.isModal = isModal
        self.framework = framework
        self.closeCallbak = closeCallbak
    }
    
    @State private var isWebViewPresented = false
    
    var body: some View {
        VStack {
            
            if(isModal){
                
                HStack{
                    
                    Spacer()
                    
                    Button(action: {
                        closeCallbak()
                    }, label: {
                        Image(systemName: "xmark")
                            .imageScale(.large)
                            .foregroundColor(Color(.label))
                            .frame(width:44,height: 44)
                    })
                }.padding()
                
                Spacer()
                
            }
            
            FrameworkItem(framework: framework)
            
            Text(framework.description)
                .font(.body)
                .padding()
            
            Spacer()
            
            Button(action: {
                isWebViewPresented = true
            }, label: {
                AFButton(label: "Learn More")
            }).fullScreenCover(isPresented : $isWebViewPresented){
                SafariView(url: URL(string: framework.urlString) ?? URL(string: "www.apple.com")!)
            }
            
        }
    }
    
}
