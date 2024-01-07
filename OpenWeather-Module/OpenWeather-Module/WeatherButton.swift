//
//  WeatherButton.swift
//  WeatherApp
//
//  Created by Pramod Singh on 03/01/24.
//

import SwiftUI


struct CustomWeatherButton: View {
    var text:String
    var backgroundColor:Color = .white
    var textColor:Color = .blue
    var body: some View {
        Text(text)
            .font(.system(size: 16,weight: .bold))
            .frame(width: 280,height: 45)
            .background(backgroundColor)
            .foregroundColor(textColor)
            .cornerRadius(10)
    }
}
