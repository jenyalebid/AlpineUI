//
//  Color.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 10/27/22.
//

import SwiftUI
import UIKit

public extension Color {

    // alpha is in first place
     init(hex: String) {
        var hexSanitized: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        if (hexSanitized.count != 6 && hexSanitized.count != 8) {
            self.init(CGColor.init(red: 0, green: 0, blue: 0, alpha: 1))
            return
        }
        var rgbValue: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgbValue)
        let a: CGFloat = hexSanitized.count == 6 ? 1.0 : CGFloat((rgbValue & 0xFF000000) >> 24) / 255.0
        let r: CGFloat = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let g: CGFloat = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let b: CGFloat = CGFloat( rgbValue & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b, opacity: a)
    }

    func toHex() -> String {
        let uic = UIColor(self)
        guard let components = uic.cgColor.components, (components.count == 3 || components.count == 4) else {
            return "#ff000000"
        }
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        let a = components.count == 4 ? Float(components[3]) : 1.0

        if a != Float(1.0) {
            return String(format: "#%02lX%02lX%02lX%02lX", lroundf(a * 255), lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        } else {
            return String(format: "#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
}
