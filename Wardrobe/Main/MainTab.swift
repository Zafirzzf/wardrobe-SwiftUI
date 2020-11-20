//
//  MainTab.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/10.
//

import SwiftUI

struct MainTab: View {

    @EnvironmentObject var store: Store
    
    var stateBinding: Binding<AppState.MainTab> {
        $store.state.mainTab
    }
    
    var body: some View {
        NavigationView {
            VStack {
                store.state.mainTab.selectIndex.content
                Spacer()
                tabBar
            }
        }
        .background(Color.white)
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: stateBinding.showInputModal, content: {
            InputNewView().environmentObject(store)
        })
    }
    
    var tabBar: some View {
        HStack {
            createTabBarItem(with: .recommend)
                .padding(.leading, 15)
            Spacer()
            addButton
            Spacer()
            createTabBarItem(with: .collect)
                .padding(.trailing, 15)
        }
        .frame(height: 49)
    }
    
    var addButton: some View {
        Button(action: {
            store.dispatch(.clickInputToAddButton)
        }, label: {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 46, height: 46)
                .foregroundColor(.yellow)
        })
    }
    
    func createTabBarItem(with index: AppState.MainTab.Index) -> some View {
        VStack(spacing: 0) {
            index.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(5)
                .frame(width: 42, height: 42)
                .background(Color(indexIsSelected(index) ? .blue : .white).opacity(0.2))
                .foregroundColor(Color(indexIsSelected(index) ? .blue : .black))
                .cornerRadius(21)
        }
        .frame(width: 100, height: 50)
        .onTapGesture {
            store.dispatch(.selectTabIndex(index: index))
        }
    }
    
    func indexIsSelected(_ index: AppState.MainTab.Index) -> Bool {
        store.state.mainTab.selectIndex == index
    }
}

struct MainTab_Previews: PreviewProvider {
    static var previews: some View {
        MainTab()
            .previewDevice("iPhone 12 mini")
            .environmentObject(Store())
    }
}
