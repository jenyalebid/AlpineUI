//
//  Nav.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 3/7/23.
//

import SwiftUI

open class Nav {
    
    static public var stack = [any Viewable]()
    static var stackCount = 0
        
//    @ViewBuilder
    static func host(object: Viewable?) -> some View {
        Text("Implement on subclass")
    }
}

public extension Nav {
    
    static func openView(for object: any Viewable) {
        Nav.stack.append(object)
        NotificationCenter.default.post(Notification(name: Notification.Name("Nav_Object_Open"), object: object))
    }
    
    static func goBack() {
        NotificationCenter.default.post(Notification(name: Notification.Name("Nav_Move"), userInfo: ["direction": "back"]))
    }
    
    static func goForward() {
        NotificationCenter.default.post(Notification(name: Notification.Name("Nav_Move"), userInfo: ["direction": "forward"]))
    }
}
