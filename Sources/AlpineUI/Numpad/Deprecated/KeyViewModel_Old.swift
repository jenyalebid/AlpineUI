//
//  KeyViewModel.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/26/22.
//

import SwiftUI

@available(*, deprecated, message: "This is an deprecated object. Use KeypadModifier to display the Keypad.")
class KeyViewModel_Old: ObservableObject {
    
    var totalSize: CGSize
    var value: String
    
    var number: String
    
    init(totalSize: CGSize, value: String, number: String) {
        self.totalSize = totalSize
        self.value = value
        self.number = number
    }
    
    func makeSize() -> (width: Double, height: Double) {
        
        var width = ((totalSize.width / 3) / 3) - 12
        let height = ((totalSize.height / 3) / 5) - 12
            
        if value == "0" {
            width = width * 2 + 6
        }
        if value == "delete" {
            width = width * 3 + 12
        }
        
        return (width, height)
    }
    
    func modifyNumber() -> String {
        var numArray = Array(number)
        
        if value == "delete" {
            guard !numArray.isEmpty else {
                return "0"
            }
            numArray.removeLast()
            if numArray.last == "." {
                numArray.removeLast()
            }
            if numArray.isEmpty {
                return "0"
            }
            return String(numArray)
        }
//        if value == "." {
//            let char = value[value.index(value.startIndex, offsetBy: 0)]
//            return number + String(char) + "0"
//        }
        else {
            let char = value[value.index(value.startIndex, offsetBy: 0)]
            return number + String(char)
        }
    }
}
