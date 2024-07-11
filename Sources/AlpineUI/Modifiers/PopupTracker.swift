//
//  PopupTracker.swift
//  FormManagmentSystem
//
//  Created by Jenya Lebid on 8/21/23.
//  Copyright © 2023 Alpine Land Information Services. All rights reserved.
//

import SwiftUI

struct PopupTracker: ViewModifier {
    
    @State private var disableContent = false
    
    //MARK: Need this becuase SwiftUI is full of bugs and its ConfirmationDialog will allow for a background tap button trigger. :-|
    
    func body(content: Content) -> some View {
        content
//            .disabled(disableContent)
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name("FMS_Popup"))) { output in
                guard let state = output.object as? Bool else { return }
                withAnimation {
                    disableContent = state
                }
            }
    }
}
