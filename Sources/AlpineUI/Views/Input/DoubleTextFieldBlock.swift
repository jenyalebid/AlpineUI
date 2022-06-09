//
//  DoubleTextFieldBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/2/22.
//

import SwiftUI

public struct DoubleTextFieldBlock: View {
    
    var lTitle: String
    var lValue: Binding<String>
    var lChanged: Binding<Bool>
    
    var rTitle: String
    var rValue: Binding<String>
    var rChanged: Binding<Bool>
    
    public init(lTitle: String, lValue: Binding<String>, lChanged: Binding<Bool>, rTitle: String, rValue: Binding<String>, rChanged: Binding<Bool>) {
        self.lTitle = lTitle
        self.lValue = lValue
        self.lChanged = lChanged
        
        self.rTitle = rTitle
        self.rValue = rValue
        self.rChanged = rChanged
    }
    
    public var body: some View {
        HStack {
            TextFieldBlock(title: lTitle, value: lValue, changed: lChanged)
            TextFieldBlock(title: rTitle, value: rValue, changed: rChanged)
        }
    }
}
