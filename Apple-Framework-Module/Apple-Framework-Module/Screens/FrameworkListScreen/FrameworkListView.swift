//
//  FrameworkListView.swift
//  Apple-Framework-Module
//
//  Created by Pramod Singh on 08/01/24.
//

import SwiftUI

#Preview {
    FrameworkListView()
}

struct FrameworkListView: View {
    
    @StateObject var viewModel = FrameworkGridViewViewModel()
    
    var body: some View {
        NavigationView{
            List {
                ForEach(MockData.frameworks){ framework in
                    
                    NavigationLink(destination: {
                        FrameworkDetailView(
                            isModal: false,
                            framework: viewModel.selectedFramework ?? MockData.sampleFramework,
                            closeCallbak:{viewModel.isFrameworkSheetShowing = false}
                        )
                    }, label: {
                        FrameworkItemHorizontal(framework: framework)
                    })
                
                }
            }.navigationTitle("Apple Frameworks")
                .padding(.top , 16)
                .padding(.bottom, 16)
                .scrollClipDisabled(true)
        }.accentColor(Color(.label))
    }
    
}
