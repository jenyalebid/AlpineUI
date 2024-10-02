//
//  KeypadViewModel.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/25/22.
//

import SwiftUI

@available(*, deprecated, message: "This is an deprecated object. Use KeypadModifier to display the Keypad.")
class KeypadViewModel_Old: ObservableObject {
    
    var keys = [
        Key(label: "7", value: .digit(7)), Key(label: "8", value: .digit(8)), Key(label: "9", value: .digit(9)),
        Key(label: "4", value: .digit(4)), Key(label: "5", value: .digit(5)), Key(label: "6", value: .digit(6)),
        Key(label: "1", value: .digit(1)), Key(label: "2", value: .digit(2)), Key(label: "3", value: .digit(3)),
        Key(label: "0", value: .digit(0)), Key(label: ".", value: .decimalPoint), Key(label: "delete", value: .delete)
    ]
    
    var rowSizes = [3, 3, 3, 2, 1]
    var rows: [KeyRow] = []
    
    init() {
        filRows()
    }
    
    func filRows() {
        var counter = 0
        for rowSize in rowSizes {
            var keyRow = KeyRow(values: [])
            for _ in 0..<rowSize {
                keyRow.values.append(keys[counter])
                counter += 1
            }
            rows.append(keyRow)
        }
    }
}
