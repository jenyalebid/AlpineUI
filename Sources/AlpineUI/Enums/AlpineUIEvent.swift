//
//  UIEvent.swift
//  
//
//  Created by Vladislav on 8/6/24.
//

import Foundation

public enum AlpineUIEvent: String {
    case dismissButton = "dismiss_button"
    case symbolGridSelected = "symbol_grid_selected"
    case textFieldButton = "text_field_button"
    case textButton = "text_button"
    case navigationLinkActivated = "navigation_link_activated"
    case multiSelectMenuSelectionChanged = "multi_select_menu_selection_changed"
    case popoverOpened = "popover_opened"
    case popoverClosed = "popover_closed"
    case tapAction = "tap_action"
    case colorAction = "color_action"
    case checkmarkAction = "checkmark_action"
    case panelAction = "panel_action"
    case toggleAction = "toggle_action"
    case booleanPickerAction = "boolean_picker_action"
    case dropdownAction = "dropdown_action"
    case openedAdvancedSettings = "opened_advanced_settings"
    case switchedDatabase = "switched_database"
    case attemptingSync = "attempting_sync"
    case labelSymbologyViewOpened = "label_symbology_view_opened"
    case rasterLayerViewOpened = "raster_layer_view_opened"
    case vectorLayerViewOpened = "vector_layer_view_opened"
    case symbologyVisibilityViewOpened = "symbology_visibility_view_opened"
}
