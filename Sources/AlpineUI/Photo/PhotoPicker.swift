//
//  CameraPhotoPicker.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 11/6/24.
//

import SwiftUI

public struct CameraPhotoPicker: UIViewControllerRepresentable {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var data: Data?
    
    public init(data: Binding<Data?>) {
        self._data = data
    }
    
    public func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        #if targetEnvironment(simulator)
        imagePicker.sourceType = .photoLibrary // no camera, so not to crash on simulator
        #else
        imagePicker.sourceType = .camera
        #endif
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
    
    public func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
    
    public class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        var photoPicker: CameraPhotoPicker
        
        init(picker: CameraPhotoPicker) {
            self.photoPicker = picker

        }
        
        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let photo = info[.editedImage] as? UIImage else { return }
            let croppedImage = resizeImage(image: photo, targetSize: CGSize(width: 1920, height: 1080))
            
            photoPicker.data = croppedImage.jpegData(compressionQuality: 0.75)
            self.photoPicker.dismiss()
        }
        
        func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
            let size = image.size
            let widthRatio  = targetSize.width  / size.width
            let heightRatio = targetSize.height / size.height
            var newSize: CGSize
            if(widthRatio > heightRatio) {
                newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
            } else {
                newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
            }
            let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
            UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
            image.draw(in: rect)
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage!
        }
    }
}
