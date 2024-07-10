//
//  Date.swift
//
//
//  Created by Vladislav on 7/10/24.
//

import Foundation

public extension Date {
    
    func toString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
