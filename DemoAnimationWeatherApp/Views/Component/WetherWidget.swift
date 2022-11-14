//
//  WetherWidget.swift
//  DemoAnimationWeatherApp
//
//  Created by IslamSwira on 14/11/2022.
//

import SwiftUI

struct WetherWidget: View {
    var forcast : Forecast
    
    var body: some View {
        ZStack(alignment: .bottom) {
            //MARK: Trapezoid
            Trapezoid()
                .fill(Color.weatherWidgetBackground)
                .frame(width: 342,height: 174)
            
            
            //MARK: Content
            HStack(alignment: .bottom) {
                VStack(alignment: .leading,spacing: 8) {
                    //MARK: Forcast Tempreture
                    Text("\(forcast.temperature)°")
                        .font(.system(size: 64))
                    
                    VStack(alignment: .leading,spacing: 2) {
                        //MARK: Forcast Tempreture Range
                        Text("H:\(forcast.high)°  L:\(forcast.low)°")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        
                        //MARK: Forcast Location
                        Text(forcast.location)
                            .font(.body)
                            .lineLimit(1)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing,spacing: 0) {
                    //MARK: Forcast Large Icon
                    Image("\(forcast.icon) large")
                        .padding(.trailing , 4)
                    
                    //MARK: Weather
                    Text(forcast.weather.rawValue)
                        .font(.footnote)
                        .padding(.trailing,24)
                }
            }
            .foregroundColor(.white)
            .padding(.bottom , 20)
            .padding(.leading , 20)
        }
        .frame(width: 342,height: 184,alignment: .bottom)
    }
}

struct WetherWidget_Previews: PreviewProvider {
    static var previews: some View {
        WetherWidget(forcast: Forecast.cities[0])
            .preferredColorScheme(.dark)
    }
}
