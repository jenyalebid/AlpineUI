//
//  SingleDropdownViewModel.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/2/22.
//

import SwiftUI

class SingleDropdownViewModel: ObservableObject {

    @Published var selection: String

    var values: [PickerOption]

    var hasOrder: Bool {
        for value in values {
            if value.order != 0 {
                return true
            }
        }
        return false
    }

    init(selection: String, values: [PickerOption]) {
        self.selection = selection
        self.values = values
        
        checkEmpty()
        sortValues()
    }
    
    func checkEmpty() {
        if values.isEmpty {
            values.append(PickerOption(primaryText: "NULL"))
        }
    }


    func sortValues() {
        if hasOrder {
            values = values.sorted { $0.order < $1.order }
        }
        else {
            values = values.sorted { $0.primaryText.lowercased() < $1.primaryText.lowercased() }
        }
    }


}
