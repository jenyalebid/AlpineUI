//
//  PKSheetManager.swift
//  PopupKit
//
//  Created by Jenya Lebid on 1/24/24.
//

import SwiftUI

@Observable
public class PKSheetManager {
    
    public static var shared = PKSheetManager()
    
    private init() {}
    
    public func presentSheet<Content: View>(style: UIModalPresentationStyle = .automatic, @ViewBuilder _ content: @escaping () -> Content) {
        DispatchQueue.main.async {
            guard let topController = UIViewController.findTopMostViewController() else {
                print("PopupKit Error: Top ViewController for active foreground Scene could not be found.")
                return
            }
            
            let hostingController = UIHostingController(rootView: content())
            hostingController.modalPresentationStyle = style
            
            topController.present(hostingController, animated: true)
        }
    }
}
