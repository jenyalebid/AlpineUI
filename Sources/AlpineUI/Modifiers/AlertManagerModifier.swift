//
//  AlertManagerModifier.swift
//  PopupKit
//
//  Created by Jenya Lebid on 1/10/24.
//

import SwiftUI

struct AlertManagerModifier: ViewModifier {
    
    @Bindable private var manager = AlertManager.shared
    @State private var currentAlert = SceneAlert(title: "Empty", message: "This should not be presented.", buttons: [.ok])
    
    private var emptyAlert = SceneAlert(title: "Empty", message: "This should not be presented.", buttons: [.ok])
    
    func body(content: Content) -> some View {
        content
            .sceneAlert(isPresented: $manager.isAlertPresented, alert: currentAlert)
            .overlay {
                PopoutView()
            }
            .onChange(of: manager.isAlertPresented) { _, presented in
                if !presented {
                    manager.presentNextIfExists()
                }
            }
            .onChange(of: manager.activeAlert) { oldValue, newValue in
                if let newValue {
                    currentAlert = newValue
                    manager.isAlertPresented = true
                }
                else {
                    currentAlert = emptyAlert
                }
            }
    }
}

