//
//  HomeView.swift
//  Apple-Framework-Module
//
//  Created by Pramod Singh on 08/01/24.
//

import SwiftUI

#Preview {
    HomeView()
}

public struct HomeView: View {
    
    @State var isGridView = false
    
    public init(){}
    
    public var body: some View {
        VStack(spacing:0){
            
            if(isGridView) {
                FrameworkGridView()
            }else {
                FrameworkListView()
            }
            
            Divider()
                                    
            Button(action: {
                isGridView.toggle()
            }, label: {
                //AFButton(label: "Toggle \(isGridView ? "List" : "Grid")")
                Label(
                    title: { Text("Toggle \(isGridView ? "List" : "Grid")") },
                    icon: {
                        Image(systemName: isGridView ? "list.bullet" : "square.grid.3x3")
                    }
                )
            })
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .tint(.blue)
            .buttonBorderShape(.roundedRectangle)
            .padding()

        }
    }
    
}
