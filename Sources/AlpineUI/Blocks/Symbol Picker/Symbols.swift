//
//  Symbols.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 7/26/23.
//

import Foundation

class Symbols {

    static let shared = Symbols()

    func loadSymbols(from fileName: String) -> [String] {
        return Self.fetchSymbols(fileName: fileName)
    }

    private static func fetchSymbols(fileName: String) -> [String] {
        guard let path = Bundle.module.path(forResource: fileName, ofType: "txt"),
              let content = try? String(contentsOfFile: path) else {
            #if DEBUG
            assertionFailure("[SymbolPicker] Failed to load bundle resource file.")
            #endif
            return []
        }
        return content
            .split(separator: "\n")
            .map { String($0) }
    }
}
