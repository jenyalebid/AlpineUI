//
//  PickerOption.swift
//  PickerOption
//
//  Created by Jenya Lebid on 11/10/22.
//

import Foundation

public struct PickerOption: Identifiable, Hashable, Codable {
    
    public var id = UUID()
    public var primaryText: String
    public var secondaryText: String?
    public var rawText: String?
    public var order: Int
    
    public init(primaryText: String?, secondaryText: String? = nil, rawText: String? = nil, order: Int = 0) {
        self.primaryText = primaryText ?? ""
        self.secondaryText = secondaryText
        self.rawText = rawText
        self.order = order
    }
}
