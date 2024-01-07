//
//  ApiManager.swift
//  WeatherApp
//
//  Created by Pramod Singh on 04/01/24.
//

import Foundation


struct OpenWeatherResponse:Decodable{
    let cod : String?
    let list : [WeatherInfo]?
}

struct WeatherInfo:Decodable{
    let main : WeatherMain?
    let weather: [Weather]?
    let dt_txt : String?
}

struct Weather:Decodable{
    let id: Int?
    let icon: String?
}

struct WeatherMain:Decodable{
    let temp: Float?
}


struct ApiManager{
    
    public static let instance = ApiManager()
    
    private let baseUrl = "https://api.openweathermap.org/data/2.5/forecast"
    
    private let app_id = "70d7b13097751b44dcd4df92b17cb667"
    
    private let decoder = JSONDecoder()
    
    func getDailyWeatherForcast(city:String) async -> Result<OpenWeatherResponse,Error> {
        
        let parameters = ["q": city, "appid": app_id, "units" : "metric"]
        
        var urlComponents = URLComponents(string: baseUrl)
        urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = urlComponents?.url else {
            return .failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil))
        }
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            do {
                let decodedResponse = try decoder.decode(OpenWeatherResponse.self, from: data)
                return .success(decodedResponse)
            } catch {
                return .failure(error)
            }
        }catch{
            return .failure(error)
        }
    }
    
    
    
    func getDailyWeatherForecast(city: String, completion: @escaping (Result<OpenWeatherResponse, Error>) -> Void) {
        
        let parameters = ["q": city, "appid": app_id]

        var urlComponents = URLComponents(string: baseUrl)
        urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }

        guard let url = urlComponents?.url else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            let decoder = JSONDecoder()
            
            
            do {
                let decodedResponse = try decoder.decode(OpenWeatherResponse.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(error))
            }

        }
    
        task.resume()
    }
    
}
