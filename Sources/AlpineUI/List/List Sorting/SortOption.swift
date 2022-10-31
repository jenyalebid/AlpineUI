//
//  SortOption.swift
//  Wildlife
//
//  Created by Jenya Lebid on 6/17/22.
//

import Foundation

public struct SortOption: Identifiable, Equatable {
    
    public var id = UUID()
    
    public var label: String
    public var key: String
    
    public init(label: String, key: String) {
        self.label = label
        self.key = key
    }
}
