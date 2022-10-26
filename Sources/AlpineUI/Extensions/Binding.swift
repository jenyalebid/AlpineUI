//
//  Binding.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 10/26/22.
//

import SwiftUI

extension Binding {
    
     public func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
