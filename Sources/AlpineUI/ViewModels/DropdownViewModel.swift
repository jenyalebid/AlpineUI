//
//  DropdownViewModel.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/3/22.
//

import SwiftUI

class DropdownViewModel: ObservableObject {
    
    var allValues: [[String]]
    
    @Published var filteredValues: [[String]] = []
    
    @Published var showDropdown = false
    @Published var selected = false
    @Published var show = false
    
    init(values: [[String]]) {
        self.allValues = values
    }
    
    func filterList(value: String) {
        if value == "" || value.count == 1 {
            filteredValues = allValues
            return
        }
        
        var filteredList: [[String]] = []
        
    outer: for values in allValues {
        for string in values {
            if string.localizedCaseInsensitiveContains(value) {
                filteredList.append(values)
                break
            }
        }
    }
        
        selected = false
        filteredValues = filteredList.sorted { ($0[0].hasPrefix(value) ? 0 : 1) < ($1[0].hasPrefix(value) ? 0 : 1) }
    }
    
    func makeSelection() {
        selected = true
        showDropdown = false
    }
}
