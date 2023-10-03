//
//  Int.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 10/3/23.
//

import Foundation

public extension Int {
    
    func toSizeString() -> String {
        let byteCountFormatter = ByteCountFormatter()
        byteCountFormatter.allowedUnits = [.useBytes, .useKB, .useMB, .useGB]
        byteCountFormatter.countStyle = .file
        return byteCountFormatter.string(fromByteCount: Int64(self))
    }
}
