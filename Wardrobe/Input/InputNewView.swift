//
//  InputNewView.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/10.
//

import SwiftUI

struct InputNewView: View {
    @EnvironmentObject var store: Store
    
    @State var isAppear = false
    
    private var state: AppState.InputNew {
        store.state.inputNew
    }
    
    private var selectWearViewModel: WearTypeViewModel? {
        state.wearType?.viewModel
    }
    
    private var stateBinding: Binding<AppState.InputNew> {
        $store.state.inputNew
    }
    
    var body: some View {
        VStack {
            topControlView
            Spacer()
            selectWearTypeView
                .opacity(isAppear ? 1.0 : 0.1)
                .offset(CGSize(width: 0, height: isAppear ? 0 : 600))
            if state.hasSelWearType {
                selectWearDetailTypeView
            }
            Spacer()
            if state.showUploadImageSelectView, state.wearImage == nil {
                uploadImageTypeSelectView
            }
            wearImageView
            Spacer()
        }
        .sheet(isPresented: stateBinding.showImageUploadView, content: {
            if state.uploadImageType == .camera {
                CameraTakePhotoView(resultImage: stateBinding.wearImage, isShow: stateBinding.showImageUploadView)
                    .ignoresSafeArea(.container, edges: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)

            } else {
                ImagePicker(resultImage: stateBinding.wearImage, isShow: stateBinding.showImageUploadView)
            }
        })
        .animation(.easeInOut(duration: 0.3))
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) {
                isAppear = true
            }
        }
    }
    
    private var topControlView: some View {
        HStack {
            Image(state.canPopPage ? "back" : "close")
                .resizable()
                .frame(width: 17, height: 17)
                .scaledToFit()
                .padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 15))
                .onTapGesture {
                    store.dispatch(.clickBack)
                }
            Divider().frame(width: 1, height: 30)
            
            ColorPicker(state.color == .clear ? .selectColorTip : "", selection: stateBinding.color, supportsOpacity: false).fixedSize()
            Spacer()
            if state.allFinished {
                Image("finish")
                    .colorMultiply(state.color)
                    .padding(.trailing, 20)
                    .onTapGesture {
                        store.dispatch(.clickFinish)
                    }
            }
        }
    }
    

    private var uploadImageTypeSelectView: some View {
        HStack {
            Spacer()
            Image(systemName: "photo")
                .resizable()
                .modifier(IconItemModifer())
                .onTapGesture {
                    store.dispatch(.selectUploadImageType(type: .library))
                }
            Spacer()
            Image(systemName: "camera")
                .resizable()
                .modifier(IconItemModifer())
                .onTapGesture {
                    store.dispatch(.selectUploadImageType(type: .camera))
                }
            Spacer()
        }
    }
    
    @ViewBuilder private var wearImageView: some View {
        if let image = state.wearImage {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
                .padding()
                .onTapGesture {
                    store.dispatch(.clickWearImage)
                }
        }
    }
}


// 一级选择列表
extension InputNewView {
    
    var selectWearTypeView: some View {
        VStack(spacing: isAppear ? 0 : -200) {
            selectWearTypeItemView(of: .clothes)
            selectWearTypeItemView(of: .pants)
            selectWearTypeItemView(of: .shoes)
        }
    }
    
    private func selectWearTypeItemView(of type: WearType) -> some View {
            HStack {
                type.viewModel.icon
                    .resizable()
                    .colorMultiply(
                        state.unSelectColor ? Color.white : state.color
                    )
                    .scaledToFit()
                    .frame(width: state.hasBeginSelectDetailKind ? 55 : 70,
                           height: state.hasBeginSelectDetailKind ? 55 : 70)
                if !state.hasBeginSelectDetailKind {
                    Spacer()
                    Text(type.viewModel.text)
                        .padding(.trailing, 40)
                }
            }
            .padding()
            .gradientBackground(backgroundColor: state.color)
            .padding()
            .offset(wearTypeItemViewOffSet(of: type))
            .opacity(wearTypeItemViewOpacity(of: type))
            .isHidden(wearTypeItemViewHidden(of: type), remove: true)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.5)) {
                    store.dispatch(.selectWearType(type: type))
                }
            }
        
    }
    
    private func wearTypeItemViewHidden(of type: WearType) -> Bool {
        if state.hasSelWearType, state.hasBeginSelectDetailKind, !state.isSelectedWearType(type) {
            return true
        } else {
            return false
        }
    }
    private func wearTypeItemViewOpacity(of type: WearType) -> Double {
        if state.hasSelWearType, !state.isSelectedWearType(type) {
            return 0
        } else {
            return 1
        }
    }
    
    private func wearTypeItemViewOffSet(of type: WearType) -> CGSize {
        if state.hasSelWearType, !state.isSelectedWearType(type) {
            return CGSize(width: -500, height: 0)
        } else {
            return .zero
        }
    }
}

// 二级选择列表
extension InputNewView {
    @ViewBuilder var selectWearDetailTypeView: some View {
        if let kind = state.detailWearKind {
            wearKindLabel(of: kind)
        } else {
            ScrollView {
                ForEach(selectWearViewModel!.subKinds, id: \.text) { kind in
                    wearKindLabel(of: kind)
                }
            }
            .opacity(state.hasBeginSelectDetailKind ? 1 : 0)
        }
    }
    
    func wearKindLabel(of kind: DetailWearKind) -> some View {
        Text(kind.text)
            .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
            .font(.title3)
            .gradientBackground(
                borderColorWidth: (Color.white, 0), backgroundColor: state.color
            )
            .onTapGesture {
                store.dispatch(.selectDetailWearKind(kind: kind))
            }
    }
}

struct InputNewView_Previews: PreviewProvider {
    static var previews: some View {
        InputNewView()
            .environmentObject(Store())
            .environment(\.locale, .init(identifier: "zh"))
            
    }
}
