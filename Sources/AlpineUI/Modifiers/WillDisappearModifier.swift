//
//  WillDisappearModifier.swift
//  
//
//  Created by Vladislav on 7/10/24.
//

import SwiftUI

public struct WillDisappearModifier: ViewModifier {
    let callback: () -> Void

    public func body(content: Content) -> some View {
        content
            .background(WillDisappearHandler(onWillDisappear: callback))
    }
}
