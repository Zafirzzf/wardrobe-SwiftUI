//
//  ImageLibraryPicker.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/12.
//

import Foundation
import UIKit
import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var resultImage: UIImage?
    @Binding var isShow: Bool
    
    func makeUIViewController(context: Context) -> UIViewController {
        let picker = PHPickerViewController(configuration: .init(photoLibrary: .shared()))
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) { }
    
    func makeCoordinator() -> Coordinate {
        Coordinate(self)
    }
    
    class Coordinate: NSObject, PHPickerViewControllerDelegate {
        private let parent: ImagePicker
        private var isLoading = false
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            if results.isEmpty {
                parent.isShow = false
                return
            }
            guard let itemProvider = results.first?.itemProvider, !isLoading else { return }
            guard itemProvider.canLoadObject(ofClass: UIImage.self) else { return }
            isLoading = true
            let superViewFrame = picker.view.frame
            let loadingFrame = CGRect(x: superViewFrame.width / 2.0 - 25, y: superViewFrame.height / 2.0 - 25, width: 50, height: 50)
            let loadingView = UIActivityIndicatorView(style: .large)
            loadingView.frame = loadingFrame
            loadingView.startAnimating()
            picker.view.addSubview(loadingView)
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                self?.isLoading = false
                DispatchQueue.main.async {
                    loadingView.removeFromSuperview()
                    if let image = image as? UIImage {
                        self?.parent.resultImage = image
                        self?.parent.isShow = false
                    } else {
                        print("Couldn't load image with error: \(error?.localizedDescription ?? "unknown error")")
                    }
                }
            }
        }
    }
}
