//
//  Key.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/25/22.
//

import Foundation

struct Key: Identifiable, Hashable {
    var id = UUID()
    var label: String
    let value: KeyValueType
    
    static func == (lhs: Key, rhs: Key) -> Bool {
        lhs.id == rhs.id
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id.uuidString)
    }
}

enum KeyValueType {
    case digit(Int)
    case decimalPoint
    case delete
}
