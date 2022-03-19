//
//  ImageCropper.swift
//  MiniInstagram
//
//  Created by İsmail on 19.03.2022.
//

import SwiftUI
import UIKit
import CropViewController

struct ImageCropper: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var visible: Bool
    var done: (UIImage) -> Void
//    @Environment(\.presentationMode) var mode
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let img = self.image ?? UIImage()
        let cropViewController = CropViewController(image: img)
        cropViewController.showActivitySheetOnDone = true
        cropViewController.delegate = context.coordinator
        print("DEBUG: cropViewController is initialized")
        return cropViewController
    }
    
    class Coordinator: NSObject, CropViewControllerDelegate {
        let parent: ImageCropper
        
        init(_ parent: ImageCropper){
            self.parent = parent
        }
        
        func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
            // some how, there maybe a bug, it can not be dismissed except adding this
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation{
                    self.parent.visible = false
                }
            }
            print("DEBUG: image cropper tapped on DONE")
            parent.done(image)
//            self.parent.mode.wrappedValue.dismiss()
        }
        
        func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
            withAnimation{
                parent.visible = false
//                self.parent.mode.wrappedValue.dismiss()
            }
        }
    }
    
   
}
