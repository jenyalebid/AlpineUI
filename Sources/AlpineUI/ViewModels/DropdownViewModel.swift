//
//  DropdownViewModel.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/3/22.
//

import SwiftUI

class DropdownViewModel: ObservableObject {

    let allValues: [[String]]
    
    @Published var filteredValues: [[String]] = []
    @Published var currentValue: String
    
    @Published var showDropdown = false
    @Published var selected = false
    @Published var show = false
    
    init(values: [[String]], currentValue: String) {
        self.allValues = values
        self.currentValue = currentValue
    }
    
    func filterList() {
        if currentValue == "" || currentValue.count == 1 {
            filteredValues = allValues
            return
        }
        
        let filteredList = allValues
            .filter { $0[0].localizedCaseInsensitiveContains(currentValue) }
            .sorted { ($0[0].hasPrefix(currentValue) ? 0 : 1) < ($1[0].hasPrefix(currentValue) ? 0 : 1) }

        selected = false

        if filteredList.isEmpty {
            showDropdown = false
        }
        else {
            filteredValues = filteredList
            showDropdown = true
        }
    }
    
    func makeSelectionWith(_ value: String) {
        currentValue = value
        selected = true
        showDropdown = false
    }
}
