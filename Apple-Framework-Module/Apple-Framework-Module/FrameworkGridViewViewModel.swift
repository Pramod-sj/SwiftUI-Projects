//
//  FrameworkGridViewViewModel.swift
//  Apple-Framework-Module
//
//  Created by Pramod Singh on 08/01/24.
//

import SwiftUI

final class FrameworkGridViewViewModel: ObservableObject{
    
    
    var selectedFramework: Framework?{
        didSet {
            isFrameworkSheetShowing = oldValue != nil
        }
    }
    
    @Published var isFrameworkSheetShowing: Bool = false
    
}