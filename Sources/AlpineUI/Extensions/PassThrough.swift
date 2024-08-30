//
//  PassThrough.swift
//  PopupKit
//
//  Created by Jenya Lebid on 9/11/23.
//

import UIKit


class PassThroughWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view == self.rootViewController?.view ? nil : view
    }
}

class PassThroughView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view == self ? nil : self
    }
}
