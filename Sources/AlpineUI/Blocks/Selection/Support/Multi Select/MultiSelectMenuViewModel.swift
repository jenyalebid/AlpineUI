//
//  MultiSelectMenuViewModel.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/3/22.
//

import SwiftUI

public class MultiSelectMenuViewModel: ObservableObject {
    
    var values: [PickerOption]
    
    var hasOrder: Bool {
        for value in values {
            if value.order != 0 {
                return true
            }
        }
        return false
    }
    
    @Published var selectedValues: [String] = []
    
    init(selections: String, values: [PickerOption]) {
        self.values = values
        self.selectedValues = makeArrayFromString(selections)
        
        sortValues()
    }
    
    
    func sortValues() {
        if hasOrder {
            values = values.sorted { $0.order < $1.order }
        }
        else {
            values = values.sorted { $0.primaryText.lowercased() < $1.primaryText.lowercased() }
        }
    }
    
    func makeArrayFromString(_ string: String) -> [String] {
        if string == "" {
            return []
        }
        return string.components(separatedBy: ", ")
    }
    
    func makeStringFromArray(_ array: [String]) -> String {
        return array.joined(separator: ", ")
    }
    
    func addRemoveFromSelection(_ value: String) -> String {
        if let index = selectedValues.firstIndex(of: value) {
            selectedValues.remove(at: index)
        }
        else {
            selectedValues.append(value)
        }
        return makeStringFromArray(selectedValues)
    }
}
