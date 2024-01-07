//
//  FrameworkGridView.swift
//  Apple-Framework-Module
//
//  Created by Pramod Singh on 07/01/24.
//

import SwiftUI


#Preview{
    FrameworkGridView()
}


struct FrameworkGridView : View{
    
    var body : some View{
        VStack{
            FrameworkItem()
        }
    }
    
}


#Preview{
    FrameworkItem()
}


struct FrameworkItem: View {
    
    var body: some View {

        VStack{
            Image(.appClip)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:80,height:80)
            Text("App Clip")
        }
        
    }
}
