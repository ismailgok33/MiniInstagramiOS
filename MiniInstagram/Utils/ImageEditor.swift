//
//  ImageEditor.swift
//  MiniInstagram
//
//  Created by İsmail on 19.03.2022.
//

import SwiftUI
import UIKit
import Mantis

struct ImageEditor: UIViewControllerRepresentable {
    typealias Coordinator = ImageEditorCoordinator
    @Binding var theImage: UIImage?
    @Binding var isShowing: Bool
    @Binding var croppedImage: UIImage?
    
    
    func makeCoordinator() -> ImageEditorCoordinator {
        return ImageEditorCoordinator(image: $theImage, isShowing: $isShowing, croppedImage: $croppedImage)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let editor = Mantis.cropViewController(image: theImage ?? UIImage())
        print("DEBUG: mantis is initialized")
        editor.delegate = context.coordinator
        return editor
    }
}

class ImageEditorCoordinator: NSObject, CropViewControllerDelegate {
    @Binding var theImage: UIImage?
    @Binding var isShowing: Bool
    @Binding var croppedImage: UIImage?
    
    init(image: Binding<UIImage?>, isShowing: Binding<Bool>, croppedImage: Binding<UIImage?>) {
        _theImage = image
        _isShowing = isShowing
        _croppedImage = croppedImage
    }
    
    func cropViewControllerDidCrop(_ cropViewController: CropViewController, cropped: UIImage, transformation: Transformation) {
        print("DEBUG: image is cropped")
        croppedImage = cropped
        isShowing = false
    }
    
    func cropViewControllerDidFailToCrop(_ cropViewController: CropViewController, original: UIImage) {
        
    }
    
    func cropViewControllerDidCancel(_ cropViewController: CropViewController, original: UIImage) {
        isShowing = false
    }
    
    func cropViewControllerDidBeginResize(_ cropViewController: CropViewController) {
        
    }
    
    func cropViewControllerDidEndResize(_ cropViewController: CropViewController, original: UIImage, cropInfo: CropInfo) {
        
    }
    
    
}
