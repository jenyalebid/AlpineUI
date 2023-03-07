//
//  NavControl.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 3/7/23.
//

import Foundation

public class NavControl: ObservableObject {
    
    static public var shared = NavControl()
    
    @Published public var sidebar = false
}
