//
//  ForcastCard.swift
//  DemoAnimationWeatherApp
//
//  Created by IslamSwira on 14/11/2022.
//

import SwiftUI

struct ForcastCard: View {
    var forcast : Forecast
    var forcasrPeriod : ForcastPeriod
    var isActive : Bool {
        if forcasrPeriod == ForcastPeriod.hourly {
            let isThisHour = Calendar.current.isDate(.now, equalTo: forcast.date, toGranularity: .hour)
            return isThisHour
        }else{
            let isDay = Calendar.current.isDate(.now, equalTo: forcast.date, toGranularity: .day)
            return isDay
        }
    }
    var body: some View {
        ZStack{
            //MARK: Card
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.forecastCardBackground.opacity(isActive ? 1 : 0.2))
                .frame(width: 60,height: 146)
                .shadow(color: .black.opacity(0.25), radius: 10,x: 5,y: 4)
                .overlay{
                    //MARK: Card Border
                    RoundedRectangle(cornerRadius: 30)
                        .strokeBorder(.white.opacity(isActive ? 0.5 : 0.2))
                        .blendMode(.overlay)
                }
                .innerShadow(shape: RoundedRectangle(cornerRadius: 30), color: .white.opacity(0.25),lineWidth: 1,offsetX: 1,offsetY: 1,blur: 0,blenMode: .overlay)
            
            //MARK: Content
            VStack(spacing : 16){
                //MARK: Forcast Date
                Text(forcast.date , format: forcasrPeriod == ForcastPeriod.hourly ? .dateTime.hour() : .dateTime.weekday())
                    .font(.subheadline.weight(.semibold))
                
                VStack(spacing : -4){
                    //MARK: Forcast Small Icon
                    Image("\(forcast.icon) small")
                    
                    //MARK: Forcast Probability
                    Text(forcast.probability, format: .percent)
                        .font(.footnote.weight(.semibold))
                        .foregroundColor(Color.probabilityText)
                        .opacity(forcast.probability > 0 ? 1 : 0)
                }
                .frame(height: 42)
                
                //MARK: Forcast Tempreture
                Text("\(forcast.temperature)°")
                
            }
            .padding(.horizontal , 8)
            .padding(.vertical , 16)
            .frame(width: 60,height: 146)
        }
    }
}

struct ForcastCard_Previews: PreviewProvider {
    static var previews: some View {
        ForcastCard(forcast: Forecast.hourly[0], forcasrPeriod: .hourly)
    }
}
