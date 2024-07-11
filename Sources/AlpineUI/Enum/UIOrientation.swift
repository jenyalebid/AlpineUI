//
//  InterfaceOrientation.swift
//  AlpineCore
//
//  Created by Jenya Lebid on 1/23/24.
//

import Foundation

public enum UIOrientation {
    case landcape
    case portrait
    case unknown
    
    public var isPortrait: Bool {
        self == .portrait
    }
    
    public var isLandscape: Bool {
        self == .landcape
    }
}
