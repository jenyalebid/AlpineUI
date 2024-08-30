//
//  PKPopoutManager.swift
//  PopupKit
//
//  Created by Jenya Lebid on 2/8/24.
//

import SwiftUI

@Observable
public class PKPopoutManager {
    
    struct Popout: Equatable {
        
        var id = UUID()
        
        var systemImage: String
        var message: String
    }
    
    public static var shared = PKPopoutManager()
        
    private init() {}
}

public extension PKPopoutManager {
    
    func makePopout(systemImage: String, message: String) {
        DispatchQueue.main.async {
            let popout = Popout(systemImage: systemImage, message: message)
            NotificationCenter.default.post(name: Notification.Name("PK_Popout"), object: popout)
        }
    }
}
