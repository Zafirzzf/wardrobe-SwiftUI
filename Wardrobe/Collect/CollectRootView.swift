//
//  CollectRootView.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/10.
//

import SwiftUI

struct CollectRootView: View {
    @EnvironmentObject var store: Store
    
    private var state: AppState.Collect {
        store.state.collect
    }
    
    private var stateBinding: Binding<AppState.Collect> {
        $store.state.collect
    }
    
    var body: some View {
        if state.allEmpty {
            emptyTipView
        } else {
            ScrollView {
                VStack {
                    getSection(of: .clothes)
                    Divider()
                    getSection(of: .pants)
                    Divider()
                    getSection(of: .shoes)
                }
            }
        }
    }
    
    private var emptyTipView: some View {
        VStack {
            Spacer()
            Image("hunger")
                .resizable()
                .frame(width: 100, height: 100)
            Text(.wardrobeEmptyTip)
            Spacer()
        }
        .foregroundColor(.mGray)
    }
    
    private func datas(of wearType: WearType) -> [Wear] {
        switch wearType {
        case .clothes: return state.clothes
        case .pants: return state.pants
        case .shoes: return state.shoes
        }
    }
    
    private func getSection(of wearType: WearType) -> some View {
        
        VStack(alignment: .leading) {
            Text(wearType.viewModel.text + "(\(datas(of: wearType).count)件)")
                .foregroundColor(.mGray)
                .padding(.leading, 20)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.flexible())], content: {
                    ForEach(datas(of: wearType), id: \.imageData) { wear in
                        wearItemView(of: wear)
                    }
                })
            }
            .frame(height: 170)
        }
    }
    
    private func wearItemView(of wear: Wear) -> some View {
        VStack {
            Image(uiImage: UIImage(data: wear.imageData) ?? UIImage(systemName: "multiply")!)
                .resizable()
                .scaledToFill()
            Text(wear.text)
                .shadow(color: .mGray, radius: 5)
        }
        .padding()
    }
}

struct CollectRootView_Previews: PreviewProvider {
    static var previews: some View {
        CollectRootView().environmentObject(Store())
    }
}
