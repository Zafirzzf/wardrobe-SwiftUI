//
//  WeatherTipView.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/16.
//

import SwiftUI
import Combine

struct WeatherTipView: View {
    @EnvironmentObject var store: Store
    
    var state: WeatherState {
        store.state.weather
    }
    
    var body: some View {
//        if state.isLoadingData {
//            ProgressView().onAppear {
//                store.dispatchWeatherAction(.startLoadWeatherData)
//            }
//        } else if state.noLocationPermission {
//            Button {
//                
//            } label: {
//                Text("开通位置权限已开启天气")
//            }
//        } else {
            weatherInfoView
//        }
    }
    
    @ViewBuilder var weatherInfoView: some View {
        if let weather = state.weather, let tomorrow = weather.tomorrow {
            VStack(alignment: .leading) {
                HStack {
                    Text(.tomorrow)
                    Text(tomorrow.text_day)
                }
                HStack {
                    Text(.weatherInfo(high: tomorrow.high, low: tomorrow.low))
                }
            }
            .foregroundColor(.mGray)
        } else {
            EmptyView()
        }
    }
}

struct WeatherTipView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherTipView().environmentObject(Store())
    }
}

