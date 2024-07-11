//
//  RequiredOverlayModifier.swift
//  FormManagmentSystem
//
//  Created by Jenya Lebid on 8/2/23.
//  Copyright © 2023 Alpine Land Information Services. All rights reserved.
//

import SwiftUI

public struct RequiredOverlayModifier: ViewModifier {
    
   public enum OverlayType {
        case field
        case button
    }
    
    var required: Bool
    var padding: CGFloat?
    var minWidth: CGFloat?
    var minHeight: CGFloat?
    var overlayType: OverlayType
    
    public func body(content: Content) -> some View {
        if overlayType == .button {
            buttonOverlay(content: content)
        } else {
            fieldOverlay(content: content)
        }
    }
    
    func fieldOverlay(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(required ? Color(uiColor: .systemRed) : Color.clear, lineWidth: 1.2)
                    .padding(padding ?? 0)
                    .frame(minWidth: minWidth, minHeight: minHeight)
            )
            .padding(.bottom)
    }
    
    func buttonOverlay(content: Content) -> some View {
        Group {
            if required {
                content
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color(uiColor: .systemRed), lineWidth: 2)
                    }
            } else {
                content
            }
        }
    }
}
