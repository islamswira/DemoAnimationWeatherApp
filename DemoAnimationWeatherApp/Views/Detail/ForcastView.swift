//
//  ForcastView.swift
//  DemoAnimationWeatherApp
//
//  Created by IslamSwira on 10/11/2022.
//

import SwiftUI

struct ForcastView: View {
    var botttomSheetTranslationProrated: CGFloat = 1
    @State private var selection = 0
    var body: some View {
        ScrollView{
            VStack(spacing : 0){
                //MARK: Segmented Control
                SegmentedControl(selection: $selection)
                
                //MARK: Forcast Cards
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack(spacing : 12){
                        if selection == 0 {
                            ForEach(Forecast.hourly) { forcast in
                                ForcastCard(forcast: forcast, forcasrPeriod: .hourly)
                            }
                            .transition(.offset(x: -430))
                        } else {
                            ForEach(Forecast.daily) { forcast in
                                ForcastCard(forcast: forcast, forcasrPeriod: .daily)
                            }
                            .transition(.offset(x: 430))
                        }
                    }
                    .padding(.vertical , 20)
                }
                .padding(.horizontal , 20)
                
                //MARK: Forcast Widgets
                Image("Forecast Widgets")
                    .opacity(botttomSheetTranslationProrated)
                
            }
            
            
            
        }
        .backgroundBlur(radius: 25,opaque: true)
        .background(Color.bottomSheetBackground)
        .clipShape(RoundedRectangle(cornerRadius: 44))
        .innerShadow(shape: RoundedRectangle(cornerRadius: 44), color: Color.bottomSheetBorderMiddle,lineWidth: 1,offsetX: 0,offsetY: 1,blur: 0,blenMode: .overlay,opacity: 1 - botttomSheetTranslationProrated )
        .overlay{
            //MARK: Bottom Sheet Seperator
            Divider()
                .blendMode(.overlay)
                .background(Color.bottomSheetBorderTop)
                .frame(maxHeight: .infinity,alignment: .top)
                .clipShape(RoundedRectangle(cornerRadius: 44))
        }
        .overlay{
            //MARK: Drag Indicator
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.black.opacity(0.3))
                .frame(width: 48,height: 5)
                .frame(height: 20)
                .frame(maxHeight: .infinity,alignment: .top)
        }
    }
}

struct ForcastView_Previews: PreviewProvider {
    static var previews: some View {
        ForcastView()
            .background(Color.background)
            .preferredColorScheme(.dark)
    }
}
