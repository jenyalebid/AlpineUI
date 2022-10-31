//
//  ListSortViewModel.swift
//  Wildlife
//
//  Created by Jenya Lebid on 6/17/22.
//

import SwiftUI

class ListSortViewModel: ObservableObject {
    
    enum Order {
        case ascending
        case descending
    }
    
    var options: [SortOption]
    @Published var order: Order = .ascending
    @Published var selection: SortOption

    
    init(selection: SortOption, options: [SortOption]) {
        self.selection = selection
        self.options = options
    }
    
    func toggleOrder() {
        if order == .ascending {
            order = .descending
        }
        else {
            order = .ascending
        }
    }
}
