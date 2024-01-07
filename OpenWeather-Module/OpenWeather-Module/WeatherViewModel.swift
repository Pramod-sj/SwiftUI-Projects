//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Pramod Singh on 04/01/24.
//

import Foundation
import Combine

class WeatherViewModel : ObservableObject{
    
    @Published var weatherUiModel: WeatherUiModel? = nil
    
    
    func fetchWetherForcast(city:String) async {
        let result = await ApiManager.instance.getDailyWeatherForcast(city: city)
        
        Task {
            switch result {
            case .success(let success):
                let items = getLatestTimeWeathers(weatherInfos: success.list ?? [])
                guard let todayWeatherInfoUi = items.first else { return }
                
                // Update @Published property on the main thread
                DispatchQueue.main.async {
                    self.weatherUiModel = WeatherUiModel(todayWeatherInfoUi: todayWeatherInfoUi, upcomingWeatherInfoUiList: Array(items.dropFirst()))
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    
    func getLatestTimeWeathers(weatherInfos:[WeatherInfo]) -> [WeatherInfoUI] {
        return weatherInfos.map{ WeatherInfoUI(dayOfWeek: "Mon", imageUrl: getWeatherIconUrl(iconCode: $0.weather?.first?.icon ?? ""), temparature: Int(round($0.main?.temp ?? 0.0))) }
    }
    
    
    func getWeatherIconUrl(iconCode:String) -> String{
        return "https://openweathermap.org/img/w/" + iconCode + ".png"
    }

    
}


struct WeatherUiModel{
    var todayWeatherInfoUi: WeatherInfoUI
    var upcomingWeatherInfoUiList: [WeatherInfoUI]
}
