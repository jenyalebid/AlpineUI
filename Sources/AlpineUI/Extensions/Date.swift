//
//  Date.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 9/19/22.
//

import Foundation

extension Date {
    
    public func toString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
