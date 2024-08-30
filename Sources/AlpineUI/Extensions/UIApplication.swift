//
//  UIApplication.swift
//  PopupKit
//
//  Created by Jenya Lebid on 8/26/23.
//

import UIKit

public extension UIApplication {
    
    static func topMostViewController(from controller: UIViewController?) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topMostViewController(from: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topMostViewController(from: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topMostViewController(from: presented)
        }
        return controller
    }
}

public extension UIApplication {
    
    var keyWindow: UIWindow? {
       connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }
}
