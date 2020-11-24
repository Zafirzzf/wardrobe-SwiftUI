//
//  ClothesScanListView.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/23.
//

import SwiftUI

struct CommonWearListView: View {
    @EnvironmentObject var store: Store
    
    var state: AppState.WearList {
        store.state.wearList
    }
    
    var wears: [Wear]
    var tapWearAction: (Wear) -> Void
    let title: String
    
    var body: some View {
        List(wears, id: \.imageData) { wear in
            wear.image
                .resizable()
                .scaledToFit()
                .shadow(color: .mGray, radius: wear.equal(with: state.currentTapedWear) ? 8 : 3)
                .onTapGesture {
                    tapWearAction(wear)
                }
        }
        .padding(.init(top: 0, leading: 20, bottom: 0, trailing: 20))
        .navigationBarTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .actionSheet(item: $store.state.wearList.actionSheetData) { actionData in
            ActionSheet(title: Text(actionData.title),
                        message: actionData.message.map(Text.init),
                        buttons: actionDataToButtons(actionData) + [.cancel()])
        }
    }
    
    func actionDataToButtons(_ actionData: ActionSheetData) -> [Alert.Button] {
        actionData.actions.map { (action) -> Alert.Button in
            return .default(Text(action.0)) {
                action.1.execute(in: store)
            }
        }
    }
}

struct ClothesScanListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CommonWearListView(wears: testWear, tapWearAction: {_ in }, title: "sdds")
        }
    }
}
