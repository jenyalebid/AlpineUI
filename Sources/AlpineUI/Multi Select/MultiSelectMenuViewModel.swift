//
//  MultiSelectMenuViewModel.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/3/22.
//

import SwiftUI

public class MultiSelectMenuViewModel: ObservableObject {
    
    @Published var selectedValues: [String] = []
    
    public init(existingSelections: String) {
        self.selectedValues = makeArrayFromString(existingSelections)
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
