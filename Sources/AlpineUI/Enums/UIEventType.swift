//
//  UIEventType.swift
//  
//
//  Created by Vladislav on 8/6/24.
//

import Foundation

public enum UIEventType: String, Codable, CaseIterable {
    case presses = "presses"
    case swipes = "swipes"
    case taps = "taps"
    case longPresses = "long_presses"
    case scrolls = "scrolls"
    case textInput = "text_input"
    case selection = "selection"
    case navigation = "navigation"
    case pinch = "pinch"
    case rotation = "rotation"
    case drag = "drag"
    case drop = "drop"
    case gesture = "gesture"
    case focusChange = "focus_change"
    case submit = "submit"
    case hover = "hover"
    case resize = "resize"
    case appear = "appear"
    case disappear = "disappear"
}
