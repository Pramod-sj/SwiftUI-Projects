//
//  FrameworkGridViewViewModel.swift
//  Apple-Framework-Module
//
//  Created by Pramod Singh on 08/01/24.
//

import SwiftUI

final class FrameworkGridViewViewModel: ObservableObject{
    
    var frameworks = MockData.frameworks
    
    var selectedFramework: Framework?{
        didSet { isFrameworkSheetShowing = true }
    }
    
    @Published var isFrameworkSheetShowing: Bool = false
    
}
