//
//  RecommendListView.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/10.
//

import SwiftUI

struct RecommendListView: View {
    
    @EnvironmentObject var store: Store
    
    var state: AppState.Recommend {
        store.state.recommend
    }
    
    var stateBinding: Binding<AppState.Recommend> {
        $store.state.recommend
    }
    
    var body: some View {
        ScrollView {
            VStack {
                tomorrowWeatherSelectView
            }
        }
        .sheet(isPresented: stateBinding.showSelectSuitType) {
            recommendSuitView
        }
        .alert(item: stateBinding.recommendSuitError) { (error) -> Alert in
            Alert(title: Text(error.description))
        }
    }
    
    var tomorrowWeatherSelectView: some View {
        VStack {
            if let suit = state.selectSuit {
                HStack {
                    Text(.tomorrowWearThis)
                    Divider()
                    Button(action: {
                        store.dispatch(.recommend(.beginSelectSuit))
                    }, label: {
                        Text(.reselect)
                    })
                }
                
            } else {
                HStack {
                    Text(.tomorrowWearWhat)
                    Divider()
                    Image(systemName: "plus.square")
                        .onTapGesture {
                            store.dispatch(.recommend(.beginSelectSuit))
                        }
                }
            }
        }
    }
    
    var recommendSuitView: some View {
        
        VStack {
            if let suit = state.recommendSuit {
                suit.clothes.image
                    .recommendItemModifier(shown: state.recommendSuitShown, delay: 0)
                suit.pants.image
                    .recommendItemModifier(shown: state.recommendSuitShown, delay: 0.5)
                suit.shoes.image
                    .recommendItemModifier(shown: state.recommendSuitShown, delay: 1)
            } else {
                Button(action: {
                    
                }, label: {
                    Text(.manualSelect)
                })
            }
        }.onAppear {
            store.dispatch(.recommend(.recommendSuitViewAppear))
        }.onDisappear {
            store.dispatch(.recommend(.recommendSuitViewDisappear))
        }
    }
}

private extension Image {
    func recommendItemModifier(shown: Bool, delay: Double) -> some View {
        resizable()
            .frame(width: shown ? 200 : 0, height: shown ? 200 : 0)
            .scaledToFill()
            .animation(Animation.easeInOut(duration: 0.3).delay(delay))
    }
}
struct RecommendListView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendListView().environmentObject(Store())
    }
}
