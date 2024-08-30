//
//  Ineternal.swift
//  PopupKit
//
//  Created by Jenya Lebid on 1/24/24.
//

import Foundation
import UIKit

internal class PK {
    
    static func findRootViewControllerInForegroundScene() -> UIViewController? {
        guard let currentScene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else {
            return nil
        }

        guard let rootViewController = currentScene.windows.first(where: { $0.isKeyWindow })?.rootViewController else {
            return nil
        }

        return rootViewController
    }
    
    static func findTopViewController(in rootViewController: UIViewController) -> UIViewController {
        if let presented = rootViewController.presentedViewController {
            return findTopViewController(in: presented)
        }
        
        return rootViewController
    }
    
    static func findTopViewControllerInForegroundScene() -> UIViewController? {
        guard let currentScene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else {
            fatalError("No connected Scene")
        }

        guard let rootViewController = currentScene.windows.first(where: { $0.isKeyWindow })?.rootViewController else {
            fatalError("No root")
        }

        return findTopViewController(in: rootViewController)
    }
}
