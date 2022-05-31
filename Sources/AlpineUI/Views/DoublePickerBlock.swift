//
//  DoublePickerBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/2/22.
//

import SwiftUI

public struct DoublePickerBlock: View {
    
    var lTitle: String
    var lValues: [[String]]
    
    @Binding var lSelection: String
    @Binding var lchanged: Bool
    
    var rTitle: String
    var rValues: [[String]]
    
    @Binding var rSelection: String
    @Binding var rChanged: Bool
    
    public init(lTitle: String, lValues: [[String]], lSelection: Binding<String>, rChanged: Binding<Bool>, rTitle: String, rValues: [[String]], rSelection: Binding<String>, lChanged: Binding<Bool>) {
        self.lTitle = lTitle
        self.lValues = lValues
        self._lSelection = lSelection
        self._lchanged = lChanged
        
        self.rTitle = rTitle
        self.rValues = rValues
        self._rSelection = rSelection
        self._rChanged = rChanged
    }
    
    public var body: some View {
        HStack {
            PickerBlock(title: lTitle, values: lValues, selection: $lSelection, changed: $lchanged)
            PickerBlock(title: rTitle, values: rValues, selection: $rSelection, changed: $rChanged)
        }
    }
}

//struct DoublePickerBlock_Previews: PreviewProvider {
//    static var previews: some View {
//        DoublePickerBlock(lTitle: "VAL 1", lValues: ["1", "2"], lSelection: Binding.constant("1"), rTitle: "VAL 12", rValues: ["1", "2"], rSelection: Binding.constant("2"))
//    }
//}
