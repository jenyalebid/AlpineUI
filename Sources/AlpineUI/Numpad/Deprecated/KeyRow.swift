//
//  KeyRow.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/25/22.
//

import Foundation

@available(*, deprecated, message: "This is an deprecated object. Use KeypadModifier to display the Keypad.")
struct KeyRow: Identifiable {
    var id = UUID()
    var values: [Key]
}


