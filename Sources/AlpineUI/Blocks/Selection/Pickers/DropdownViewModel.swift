//
//  DropdownViewModel.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/3/22.
//

import SwiftUI

class DropdownViewModel: ObservableObject {
    
    @Published var filteredValues: [PickerOption] = []
    @Published var showDropdown = false
    @Published var selected = false
    @Published var show = false
    
    var allValues: [PickerOption]
    
    init(values: [PickerOption]) {
        self.allValues = values
        checkEmpty()
    }
    
    func checkEmpty() {
        if allValues.isEmpty {
            allValues.append(PickerOption(primaryText: "NULL"))
        }
    }
    
    func filterList(value: String) {
        if value == "" || value.count == 1 {
            filteredValues = allValues.sorted { $0.primaryText.lowercased() < $1.primaryText.lowercased() }
            return
        }
        
        var filteredList: [PickerOption] = []
        
        for option in allValues {
            if option.primaryText.localizedCaseInsensitiveContains(value) {
                filteredList.append(option)
            }
            else if let secondary = option.secondaryText {
                if secondary.localizedCaseInsensitiveContains(value) {
                    filteredList.append(option)
                }
            }
        }
        
        selected = false
        filteredValues = filteredList.sorted { ($0.primaryText.hasPrefix(value) ? 0 : 1) < ($1.primaryText.hasPrefix(value) ? 0 : 1) }
    }
    
    func makeSelection() {
        selected = true
        showDropdown = false
    }
}
