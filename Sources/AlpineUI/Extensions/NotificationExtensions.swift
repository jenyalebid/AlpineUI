//
//  File 2.swift
//  
//
//  Created by Vladislav on 7/10/24.
//

import Foundation
import UIKit

public extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
    
    static func viewUpdate(with id: String) -> Notification {
        Notification(name: Notification.Name("View_Update"), object: nil, userInfo: ["id": id])
    }
}
