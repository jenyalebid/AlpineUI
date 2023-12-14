//
//  FillPatternView.swift
//  AlpineUI
//
//  Created by mkv on 12/13/23.
//

import SwiftUI
import SkiaSharpKit

public protocol FillPatternView {
    
    func getView(for pattern: String, hatchWidth: Int, fillPercent: Int) -> SKDrawView
}
