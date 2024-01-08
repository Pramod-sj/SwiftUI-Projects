//
//  AFButton.swift
//  Apple-Framework-Module
//
//  Created by Pramod Singh on 08/01/24.
//

import SwiftUI


struct AFButton : View {
    
    let label : String
    
    var body: some View {
        Text(label)
            .frame(width: 180, height: 40)
            .foregroundColor(.white)
            .background(.red)
            .cornerRadius(10)
    }
}
