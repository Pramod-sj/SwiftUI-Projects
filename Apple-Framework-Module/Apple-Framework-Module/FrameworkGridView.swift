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
    
    let columns : [GridItem] = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    
    
    public init(){}
    
    public var body : some View{
        NavigationView{
            ScrollView{
                LazyVGrid(columns: columns){
                    ForEach(MockData.frameworks){ framework in
                        FrameworkItem(framework: framework)
                            .onTapGesture {
                                viewModel.selectedFramework = framework
                            }
                    }
                }.padding()
            }.navigationTitle("Apple Frameworks")
                .sheet(isPresented: $viewModel.isFrameworkSheetShowing){
                    FrameworkDetailModal(framework: viewModel.selectedFramework ?? MockData.sampleFramework,
                    closeCallbak: {
                        viewModel.isFrameworkSheetShowing = false
                    })
                }
        }
    }
    
}


struct FrameworkItem: View {
    
    let framework: Framework
    
    var body: some View {

        VStack{
            Image(resolveNameToImageResource(name: framework.imageName))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:80,height:80)
            Text(framework.name)
                .font(.title3)
                .fontWeight(.bold)
        }
        
    }
}
