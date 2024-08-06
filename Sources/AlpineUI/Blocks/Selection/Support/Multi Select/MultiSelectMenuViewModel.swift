//
//  MultiSelectMenuViewModel.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/3/22.
//

import SwiftUI

public class MultiSelectMenuViewModel: ObservableObject {
    
    @Published var selectedValues: [String] = []
    
    private var hasOrder: Bool {
        for value in values {
            if value.order != 0 {
                return true
            }
        }
        return false
    }
    
    var values: [PickerOption]
    
    init(selections: String, values: [PickerOption]) {
        self.values = values
        checkEmpty()
        self.selectedValues = makeArrayFromString(selections)
        sortValues()
    }
    
    private func checkEmpty() {
        if values.isEmpty {
            values.append(PickerOption(primaryText: "NULL"))
        }
    }
    
    private func sortValues() {
        if hasOrder {
            values = values.sorted { $0.order < $1.order }
        } else {
            values = values.sorted { $0.primaryText.lowercased() < $1.primaryText.lowercased() }
        }
    }
    
    private func makeArrayFromString(_ string: String) -> [String] {
        if string == "" {
            return []
        }
        let components = string.components(separatedBy: ", ")
        if components.count == 1 {
            if components[0].contains(",") {
                return string.components(separatedBy: ",")
            }
        }
        return components
    }
    
    private func makeStringFromArray(_ array: [String]) -> String {
        return array.joined(separator: ", ")
    }
    
    func addRemoveFromSelection(_ value: String) -> String {
        if let index = selectedValues.firstIndex(of: value) {
            selectedValues.remove(at: index)
        } else {
            selectedValues.append(value)
        }
        return makeStringFromArray(selectedValues)
    }
}
