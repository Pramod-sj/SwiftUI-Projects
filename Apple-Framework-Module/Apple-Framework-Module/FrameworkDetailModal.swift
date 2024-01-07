//
//  FrameworkDetailModal.swift
//  Apple-Framework-Module
//
//  Created by Pramod Singh on 07/01/24.
//

import SwiftUI


#Preview {
    FrameworkDetailModal(framework: MockData.sampleFramework){}
}

struct FrameworkDetailModal : View {
    
    let framework: Framework
    
    let closeCallbak: () -> Void
    
    var body: some View {
        VStack {
            
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
            
            FrameworkItem(framework: framework)
            
            Text(framework.description)
                .font(.body)
                .padding()
            
            Spacer()
            
            Button(action: {
                print("Hello I'm Button")
            }, label: {
                Text("Learn More")
                    .frame(width: 180, height: 40)
                    .foregroundColor(.white)
                    .background(.red)
                    .cornerRadius(10)
            })
            
        }
    }
    
}
