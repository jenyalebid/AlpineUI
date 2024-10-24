//
//  Animation.swift
//  AlpineUI
//
//  Created by Vladislav on 9/30/24.
//

import SwiftUI

extension Animation {
    static func smoothEaseInOut(duration: Double = 0.5) -> Animation {
        .easeInOut(duration: duration)
    }
}
