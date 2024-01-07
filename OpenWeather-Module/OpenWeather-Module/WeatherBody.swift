//
//  ContentView.swift
//  WeatherApp
//
//  Created by Pramod Singh on 03/01/24.
//

import SwiftUI


enum WetherIconType {
    case CloudSunFill, WindSnow, Wind, Snow, SunsetFill
}

func getImageNameFromIconType(iconType:WetherIconType) -> String{
  switch iconType{
  case .CloudSunFill : return "cloud.sun.fill"
  case .WindSnow : return "wind.snow"
  case .Wind : return "wind"
  case .Snow : return "snow"
  case .SunsetFill : return "sunset.fill"
    }
}



struct WeatherInfoUI: Hashable{
    var dayOfWeek:String
    var imageUrl:String
    var temparature:Int
}


public struct WeatherBody: View {
    
    @StateObject private var viewModel = WeatherViewModel()
    
    @State private var isNightMode = false
    
    public init(){}
    
    public var body: some View {
        ZStack{
            BackgroundView(isNightMode: $isNightMode)
            VStack{
                
                CityNameView(name: "Mumbai, MH")
                
                if let latestWetherInfo = viewModel.weatherUiModel?.todayWeatherInfoUi {
                    BigWetherInfoView(imageUrl: latestWetherInfo.imageUrl,
                                      temparature: latestWetherInfo.temparature)
                }

                ScrollView(.horizontal) {
                    HStack(spacing: 20){
                        
                        ForEach(viewModel.weatherUiModel?.upcomingWeatherInfoUiList ?? [],id: \.self) { wetherInfo  in
                            WetherInfoItemView(dayOfWeek: wetherInfo.dayOfWeek,
                                               imageUrl: wetherInfo.imageUrl,
                                               temparature: wetherInfo.temparature)
                        }
                        
                    }.padding(.leading,16)
                        .padding(.trailing,16)
                        .onAppear {
                        Task{
                            await viewModel.fetchWetherForcast(city:"Mumbai")
                        }
                    }
                }
                
                Spacer()
                
                Button{
                    isNightMode.toggle()
                }label: {
                    CustomWeatherButton(text: "Change Day Time",backgroundColor: .white,textColor: .blue)
                }
               
            }
        }
    }
}

#Preview {
    WeatherBody()
}

struct WetherInfoItemView: View {

    var dayOfWeek:String
    var imageUrl:String
    var temparature:Int
    
    var body: some View {
        VStack(spacing: 2){
            Text(dayOfWeek)
                .font(.system(size: 16,weight: .medium))
                .foregroundStyle(.white)
            
            AsyncImage(url: URL(string: imageUrl)){result in
                switch result {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.scaledToFit()
                case .failure(_):
                    Image(systemName: "cloud.sun.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }.frame(width: 40,height: 40)
                
            
            Text("\(temparature)°")
                .font(.system(size: 16,weight: .medium))
                .foregroundStyle(.white)
        }
    }
}

struct BackgroundView: View {
 
    @Binding var isNightMode: Bool
    
    var body: some View {
        LinearGradient(colors: [isNightMode ? .black : .blue,
                                isNightMode ? .gray: .lightBlue], startPoint: .topTrailing, endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
}

struct CityNameView: View {
    var name:String
    var body: some View {
        Text(name)
            .font(.system(size: 32,weight: .medium))
            .foregroundStyle(.white)
            .padding()
    }
}

struct BigWetherInfoView: View {
    var imageUrl:String
    var temparature:Int
    var body: some View {
        VStack(spacing:8){
            AsyncImage(url: URL(string: imageUrl)){result in
                switch result {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure(_):
                    Image(systemName: "cloud.sun.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }.frame(width: 180,height: 180)
            Text("\(temparature)°")
                .font(.system(size: 70,weight: .medium))
                .foregroundStyle(.white)
        }.padding(.bottom,40)
    }
}
