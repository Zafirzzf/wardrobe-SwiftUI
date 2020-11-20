//
//  CameraViewController.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/13.
//

import Foundation
import SwiftUI

struct CameraTakePhotoView: UIViewControllerRepresentable {
    
    @Binding var resultImage: UIImage?
    @Binding var isShow: Bool
    
    func makeUIViewController(context: Context) -> UIViewController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) { }
    
    func makeCoordinator() -> Coordinate {
        Coordinate(self)
    }
    
    class Coordinate: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: CameraTakePhotoView
        
        init(_ parent: CameraTakePhotoView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let resultImage = (info[.originalImage] as? UIImage)
                .flatMap({ $0.jpegData(compressionQuality: 0.7) })
                .flatMap(UIImage.init)
            parent.resultImage = resultImage
            parent.isShow = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isShow = false
        }
    }
}
