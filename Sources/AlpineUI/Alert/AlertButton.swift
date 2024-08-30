//
//  AlertButton.swift
//  PopupKit
//
//  Created by Jenya Lebid on 8/23/23.
//

import Foundation
import UIKit

public struct AlertButton: Equatable {
    
    public static func == (lhs: AlertButton, rhs: AlertButton) -> Bool {
        lhs.title == rhs.title
    }
    
    public init(title: String, style: UIAlertAction.Style = .default, action: @escaping () -> Void) {
        self.title = title
        self.style = style
        self.action = action
    }
    
    var title: String
    var action: () -> Void
    var style: UIAlertAction.Style
}

public extension AlertButton {
    
    var uiAction: UIAlertAction {
        let action = UIAlertAction(title: title, style: style) { _ in
            self.action()
        }
        
        return action
    }
}

public extension AlertButton {
    
    static var ok: AlertButton {
        AlertButton(title: "Okay", style: .default, action: {})
    }
    
    static var cancel: AlertButton {
        AlertButton(title: "Cancel", style: .cancel, action: {})
    }
    
    static var notNow: AlertButton {
        AlertButton(title: "Not Now", style: .cancel, action: {})
    }
}

