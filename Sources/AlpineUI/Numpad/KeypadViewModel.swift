//
//  KeypadViewModel.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/25/22.
//

import SwiftUI

class KeypadViewModel: ObservableObject {
    
    var keys = [Key(value: "7"), Key(value: "8"), Key(value: "9"), Key(value: "4"), Key(value: "5"), Key(value: "6"), Key(value: "1"), Key(value: "2"), Key(value: "3"), Key(value: "0"), Key(value: "."), Key(value: "delete")]
    
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
