//
//  Color.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 10/27/22.
//

import SwiftUI
import UIKit

extension Color {
    
    public init(hexString: String) {
         let scanner = Scanner(string: hexString)
         var hexValue: UInt64 = 0
         if scanner.scanHexInt64(&hexValue) {
             let r = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
             let g = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
             let b = CGFloat((hexValue & 0x0000FF00) >> 8) / 255.0
             let a = CGFloat(hexValue & 0x000000FF) / 255.0
             
             self.init(red: r, green: g, blue: b, opacity: a)
         } else {
             self.init(.red) // Fallback color in case of an error
         }
     }
    
    public init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        let length = hexSanitized.count

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            self.init(CGColor.init(red: 0, green: 0, blue: 0, alpha: 1))
            return
        }

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0

        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0

        } else {
            self.init(CGColor.init(red: 0, green: 0, blue: 0, alpha: 1))
        }

        self.init(red: r, green: g, blue: b, opacity: a)
    }
    
    public func toHex() -> String? {
        let uic = UIColor(self)
        guard let components = uic.cgColor.components, components.count >= 3 else {
            return nil
        }
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)

        if components.count >= 4 {
            a = Float(components[3])
        }

        if a != Float(1.0) {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
}
