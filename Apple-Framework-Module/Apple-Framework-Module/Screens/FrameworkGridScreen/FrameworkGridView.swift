//
//  FrameworkGridView.swift
//  Apple-Framework-Module
//
//  Created by Pramod Singh on 07/01/24.
//

import SwiftUI


#Preview{
    FrameworkGridView()
        .preferredColorScheme(.dark)
}


public struct FrameworkGridView : View{
    
    @StateObject var viewModel = FrameworkGridViewViewModel()
    
    private let columns : [GridItem] = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    
    public init(){}
    
    public var body : some View{
        
        NavigationStack{
            ScrollView{
                LazyVGrid(columns: columns){
                    ForEach(viewModel.frameworks){ framework in
                        NavigationLink(value: framework, label: {
                            FrameworkItem(framework: framework)
                        })
                    }
                }.padding()
            }.navigationTitle("Apple Frameworks")
                .navigationDestination(for: Framework.self){framework in
                    FrameworkDetailView(isModal: false, framework: framework)
                }.accentColor(Color(.label))
        }
        
        
//        NavigationView{
//            ScrollView{
//                LazyVGrid(columns: columns){
//                    ForEach(MockData.frameworks){ framework in
//                        FrameworkItem(framework: framework)
//                            .onTapGesture {
//                                viewModel.selectedFramework = framework
//                            }
//                    }
//                }.padding()
//            }.navigationTitle("Apple Frameworks")
//                .sheet(isPresented: $viewModel.isFrameworkSheetShowing){
//                    FrameworkDetailView(
//                        framework: viewModel.selectedFramework ?? MockData.sampleFramework,
//                    closeCallbak: {
//                        viewModel.isFrameworkSheetShowing = false
//                    })
//                }
//        }
    }
    
}
