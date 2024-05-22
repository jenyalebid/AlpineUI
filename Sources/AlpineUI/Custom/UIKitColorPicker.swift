//
//  SwiftUIView.swift
//  
//
//  Created by Jenya Lebid on 5/22/24.
//

import SwiftUI

public struct UIKitColorPicker: UIViewControllerRepresentable {
    
    @Binding var selectedColor: Color
    
    public init(selectedColor: Binding<Color>) {
        self._selectedColor = selectedColor
    }

    public class Coordinator: NSObject, UIColorPickerViewControllerDelegate {
        var parent: UIKitColorPicker

        init(parent: UIKitColorPicker) {
            self.parent = parent
        }

        public func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
            parent.selectedColor = Color(viewController.selectedColor)
        }
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    public func makeUIViewController(context: Context) -> UIColorPickerViewController {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = context.coordinator
        colorPicker.preferredContentSize = CGSize(width: 300, height: 400) // Set the desired size
        colorPicker.selectedColor = UIColor(selectedColor)
        return colorPicker
    }

    public func updateUIViewController(_ uiViewController: UIColorPickerViewController, context: Context) {
        uiViewController.selectedColor = UIColor(selectedColor)
    }
}
