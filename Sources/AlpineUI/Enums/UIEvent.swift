//
//  UIEvent.swift
//  
//
//  Created by Vladislav on 8/6/24.
//

import Foundation

public enum UIEvent: String {
    case dismissButton = "dismiss_button"
    case symbolGridSelected = "symbol_grid_selected"
    case textFieldButton = "text_field_button"
    case textButton = "text_button"
    case settingTap = "setting_tap"
    case navigationLinkActivated = "navigation_link_activated"
    case colorSelectorOpened = "color_selector_opened"
    case colorSelected = "color_selected"
    case multiSelectMenuSelectionChanged = "multi_select_menu_selection_changed"
    case popoverOpened = "popover_opened"
    case popoverClosed = "popover_closed"
    case dropdownOpened = "dropdown_opened"
    case dropdownSelection = "dropdown_selection"
    case dropdownSelectionChanged = "dropdown_selection_changed"
    case checkmarkToggled = "checkmark_toggled"
    case openPanel = "open_panel"
    case toggleChanged = "toggle_changed" 
    case booleanPickerChanged = "boolean_picker_changed"
    case colorPickerChanged = "color_picker_changed"
    case colorTextChanged = "color_text_changed"
}


//eventTracker: Core.eventTracker)
