//
//  WeatherView.swift
//  DemoAnimationWeatherApp
//
//  Created by IslamSwira on 14/11/2022.
//

import SwiftUI

struct WeatherView: View {
    @State private var searchText = ""
    var searchResults : [Forecast] {
        if searchText.isEmpty {
            return Forecast.cities
        }else{
            return Forecast.cities.filter { $0.location.contains(searchText)}
        }
    }
    
    var body: some View {
        ZStack{
            //MARK: Backgoround
            Color.background
                .ignoresSafeArea()
            
            //MARK: Weather Widgets
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20){
                    ForEach(searchResults){ forcast in
                        WetherWidget(forcast: forcast)
                    }
                }
            }
            .safeAreaInset(edge: .top) {
                EmptyView()
                    .frame(height: 110)
            }
        }
        .overlay{
            //MARK: Navigation Bar
            NavigationBar(searchText: $searchText)
        }
        .navigationBarHidden(true)
//        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always),prompt: "Search for city or airport")
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WeatherView()
                .preferredColorScheme(.dark)
        }
    }
}
