//
//  SceneAlertModifier.swift
//  PopupKit
//
//  Created by Jenya Lebid on 1/7/24.
//

import SwiftUI
import UIKit

struct SceneAlertModifier: ViewModifier {
    
    @Binding var isPresented: Bool
    let alert: SceneAlert

    func body(content: Content) -> some View {
        content
            .onChange(of: isPresented) { _, newValue in
                print(#function)
                if newValue {
                    presentAlert()
                }
            }
    }

    private func presentAlert() {
        guard let topViewController = UIViewController.findTopMostViewController() else { return }
        let alertController = alert.uiAlert
        topViewController.present(alertController, animated: true) {
            self.isPresented = false
        }
    }
}
