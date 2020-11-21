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
                topTipView
                tomorrowSuitView
            }
        }
        .sheet(isPresented: stateBinding.showSelectSuitType) {
            recommendSuitView
        }
        .alert(item: stateBinding.suitGenerate.recommendSuitError) { (error) -> Alert in
            Alert(title: Text(error.description))
        }
    }
    
    var topTipView: some View {
        HStack {
            Text(state.tomorrowSuit == nil ? .tomorrowWearWhat : .tomorrowWearThis)
            Divider()
            Button(action: {
                store.dispatch(.recommend(.beginSelectSuit))
            }, label: {
                Text(state.tomorrowSuit == nil ? .gotoSelect : .reselect)
            })
        }
    }
    
    var tomorrowSuitView: some View {
        HStack {
            if let suit = state.tomorrowSuit {
                if let lining = suit.lining {
                    lining.image
                        .resizable()
                        .scaledToFill()
                }
                suit.clothes.image
                    .resizable()
                    .scaledToFill()
                suit.pants.image
                    .resizable()
                    .scaledToFill()
                suit.shoes.image
                    .resizable()
                    .scaledToFill()
            } else {
                Image("demoClothes.JPG")
            }
        }
    }
    
    var recommendSuitView: some View {
        ScrollView {
            VStack {
                if let suit = state.suitGenerate.recommendSuit {
                    recommendSuitTopView
                        .padding(.top, 14)
                        .padding(.bottom, 8)
                    if let lining = suit.lining {
                        lining.image.recommendItemModifier(shown: state.suitGenerate.recommendSuitSetFinish, delay: 0)
                    }
                    suit.clothes.image
                        .recommendItemModifier(shown: state.suitGenerate.recommendSuitSetFinish, delay: 0)
                    suit.pants.image
                        .recommendItemModifier(shown: state.suitGenerate.recommendSuitSetFinish, delay: 0.5)
                    suit.shoes.image
                        .recommendItemModifier(shown: state.suitGenerate.recommendSuitSetFinish, delay: 1)
                } else {
                    Button(action: {
                        
                    }, label: {
                        Text(.manualSelect)
                    })
                }
            }.onDisappear {
                store.dispatch(.recommend(.recommendSuitViewDisappear))
            }
        }
    }
    
    private var recommendSuitTopView: some View {
        VStack {
            HStack {
                Spacer()
                suitViewButton(text: .reRecommend, image: "refresh") {
                    store.dispatch(.recommend(.reRecommendSuit))
                }
                Spacer()
                suitViewButton(text: .manualSelect, image: "manual") {
                    store.dispatch(.recommend(.manualSelectSuit))
                }
                Spacer()
            }
            .padding(.bottom, 10)
            suitViewButton(text: .thisSuitBingo, image: "bingo") {
                store.dispatch(.recommend(.confirmTheSuit))
            }
        }
        .opacity(state.suitGenerate.recommendSuitSetFinish ? 1 : 0)
        .animation(Animation.easeInOut(duration: 0.25)
                    .delay(state.suitGenerate.recommendSuitSetFinish ? 1.2 : 0))
    }
    
    private func suitViewButton(text: LocalizedStringKey, image: String, action: @escaping () -> Void) -> some View {
        Button(action: action, label: {
            Text(text)
            Image(image)
        })
        .padding(.init(top: 3, leading: 8, bottom: 3, trailing: 3))
        .background(
            RoundedRectangle(cornerRadius: 5, style: .circular)
                .stroke(lineWidth: 2.0)
        )
        .foregroundColor(.mGray)
    }
}

private extension Image {
    func recommendItemModifier(shown: Bool, delay: Double) -> some View {
        resizable()
            .frame(width: shown ? 200 : 0, height: shown ? 200 : 0)
            .scaledToFill()
            .animation(Animation.easeInOut(duration: 0.3).delay(shown ? delay : 0))
    }
}
struct RecommendListView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendListView().environmentObject(Store())
    }
}
