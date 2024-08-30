//
//  UIViewController.swift
//  PopupKit
//
//  Created by Jenya Lebid on 8/26/23.
//

import UIKit

public extension UIViewController  {
    
    func removeAllChildren() {
        children.forEach {$0.removeFromParent()}
    }
    
    static func findTopMostViewController(base: UIViewController? = nil) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return PK.findTopViewController(in: nav)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return PK.findTopViewController(in: selected)
            }
            return PK.findTopViewController(in: tab)
        }
        if let presented = base?.presentedViewController {
            return PK.findTopViewController(in: presented)
        }
        
        if let root = UIApplication.shared.windows.first?.rootViewController {
            return PK.findTopViewController(in: root)
        }
        
        fatalError("No Base")
    }
}
