//
//  CollectRootView.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/10.
//

import SwiftUI

struct CollectRootView: View {
    @EnvironmentObject var store: Store
    
    private var state: AppState.WearsCollect {
        store.state.wearsState
    }
    
    private var stateBinding: Binding<AppState.WearsCollect> {
        $store.state.wearsState
    }
    
    var body: some View {
        if state.allEmpty {
            emptyTipView
        } else {
            List([
                getListRowData(of: .clothes),
                getListRowData(of: .pants),
                getListRowData(of: .shoes)
            ], id: \.title) { rowData in
                NavigationLink(
                    destination: detailDestinationView(rowData: rowData),
                    label: {
                        getSectionView(of: rowData)
                    })
            }
        }
    }
    
    private func detailDestinationView(rowData: CollectListRowData) -> some View {
        CommonWearListView(wears: rowData.wears, tapWearAction: { wear in
            store.dispatch(.collect(.tapDetailWear(wear)))
        }, title: rowData.title)
    }
    
    private func getListRowData(of wearType: WearType) -> CollectListRowData {
        switch wearType {
        case .clothes:
            return .init(wearType: wearType, wears: state.clothes)
        case .pants:
            return .init(wearType: wearType, wears: state.pants)
        case .shoes:
            return .init(wearType: wearType, wears: state.shoes)
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

    
    private func getSectionView(of rowData: CollectListRowData) -> some View {
        VStack(alignment: .leading) {
            Text(rowData.title + "(\(rowData.wears.count)件)")
                .foregroundColor(.mGray)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.flexible())], content: {
                    ForEach(rowData.wears, id: \.imageData) { wear in
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
            Text(wear.kind.text)
                .shadow(color: .mGray, radius: 5)
        }
        .padding()
    }
}

private struct CollectListRowData {
    let wearType: WearType
    var title: String {
        wearType.viewModel.text
    }
    let wears: [Wear]
}

struct CollectRootView_Previews: PreviewProvider {
    static var previews: some View {
        CollectRootView().previewDevice("iPhone 12 mini").environmentObject(Store())
    }
}
