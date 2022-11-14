//
//  HomeView.swift
//  DemoAnimationWeatherApp
//
//  Created by IslamSwira on 10/11/2022.
//

import SwiftUI
import BottomSheet

enum BottomSheetPosition: CGFloat,CaseIterable{
    case top = 0.83 // 702/844
    case middile = 0.385 // 325/844
}

struct HomeView: View {
    @State var bottomSheetPostion : BottomSheetPosition = .middile
    @State var botttomSheetTranslation: CGFloat = BottomSheetPosition.middile.rawValue
    @State var hasDragged : Bool = false
    
    var botttomSheetTranslationProrated: CGFloat {
        (botttomSheetTranslation - BottomSheetPosition.middile.rawValue) / (BottomSheetPosition.top.rawValue - BottomSheetPosition.middile.rawValue)
    }
    
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                let screenHeight = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
                let imageOffset = screenHeight + 36
                
                ZStack{
                    //MARK: Background Color
                    Color.background
                        .ignoresSafeArea()
                    
                    //MARK: Background Image
                    Image("Background")
                        .resizable()
                        .ignoresSafeArea()
                        .offset(y: -botttomSheetTranslationProrated * imageOffset)
                        
                    
                    //MARK: House Image
                    Image("House")
                        .frame(maxHeight: .infinity,alignment: .top)
                        .padding(.top,257)
                        .offset(y: -botttomSheetTranslationProrated * imageOffset)
                    
                    //MARK: Current Weather
                    VStack(spacing:-10 * (1 - botttomSheetTranslationProrated )){
                        Text("Montreal")
                            .font(.largeTitle)
                        
                        
                        VStack{
                            Text(attributedString)
                            
                            Text("H:24°   L:18°")
                                .font(.title3.weight(.semibold))
                                .opacity(1 - botttomSheetTranslationProrated)
                        }
                        Spacer()
                    }
                    .padding(.top,51)
                    .offset(y: -botttomSheetTranslationProrated * 46)
                    
                    //MARK: BottomSheet
                    BottomSheetView(position: $bottomSheetPostion) {
//                        Text(botttomSheetTranslationProrated.formatted())
                    } content: {
                        ForcastView(botttomSheetTranslationProrated : botttomSheetTranslationProrated)
                    }
                    .onBottomSheetDrag { translation in
                        botttomSheetTranslation = translation / screenHeight
                        
                        withAnimation(.easeInOut){
                            if bottomSheetPostion == BottomSheetPosition.top{
                                hasDragged = true
                            }else{
                                hasDragged = false
                            }
                        }
                    }

                    
                    //MARK: Tab Bar
                    TabBar(action: {
                        bottomSheetPostion = .top
                    })
                    .offset(y: botttomSheetTranslationProrated * 115)
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    
    private var attributedString: AttributedString{
        var string = AttributedString("19°" + (hasDragged ? " | " : "\n ") + "Mostly Clear")
        
        if let temp = string.range(of: "19°"){
            string[temp].font = .system(size: (96 - (botttomSheetTranslationProrated * (96 - 20))),weight: hasDragged ? .semibold : .thin)
            string[temp].foregroundColor = hasDragged ? .secondary : .primary
        }
        
        if let pipe = string.range(of: " | "){
            string[pipe].font = .title3.weight(.semibold)
            string[pipe].foregroundColor = .secondary.opacity(botttomSheetTranslationProrated)
        }
        
        if let weather = string.range(of: "Mostly Clear"){
            string[weather].font = .title3.weight(.semibold)
            string[weather].foregroundColor = .secondary
        }
        return string
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
