//
//  FrameworkItemView.swift
//  Apple-Framework-Module
//
//  Created by Pramod Singh on 08/01/24.
//

import SwiftUI

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
                .fontWeight(.semibold)
                .scaledToFit()
                .minimumScaleFactor(0.6)
        }
        
    }
}
