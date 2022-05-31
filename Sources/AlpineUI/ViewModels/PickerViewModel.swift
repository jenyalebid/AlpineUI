//
//  PickerViewModel.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/2/22.
//

import SwiftUI

class PickerViewModel: ObservableObject {
    
    @Published var selection: String
    
    init(selection: String) {
        self.selection = selection
    }
}
