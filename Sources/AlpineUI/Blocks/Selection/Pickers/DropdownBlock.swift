//
//  DropdownBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/3/22.
//

import SwiftUI

public struct DropdownBlock: View {
        
    @Environment(\.isEnabled) private var isEnabled
    
    @Binding var selection: String
    @Binding var changed: Bool
    
    @FocusState private var focused: Bool
    @StateObject private var viewModel: DropdownViewModel
    
    private var title: String?
    private var placeHolder: String?
    private var controlField: Bool
    private var required: Bool
    private var sendKeyboardUpdate: Bool
    private var allowBlank: Bool
    private var onEvent: ((AlpineUIEvent, [String: Any]?) -> Void)?
    
    public init(placeHolder: String? = nil, title: String? = nil, values: [PickerOption], selection: Binding<String>, required: Bool = false, controlField: Bool = false, changed: Binding<Bool>, sendKeyboardUpdate: Bool = false, allowBlank: Bool = false, onEvent: ((AlpineUIEvent, [String: Any]?) -> Void)? = nil) {
        self.title = title
        self.placeHolder = placeHolder
        self._selection = selection
        self.required = required
        self.controlField = controlField
        self._changed = changed
        self.onEvent = onEvent
        self.sendKeyboardUpdate = sendKeyboardUpdate
        self.allowBlank = allowBlank
        
        _viewModel = StateObject(wrappedValue: DropdownViewModel(values: values))
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            if title != nil {
                Text("\(title!):").font(.footnote)
            }
            field
                .popover(isPresented: $viewModel.showDropdown) {
                    BetterList {
                        ForEach(viewModel.filteredValues) { value in
                            VStack(alignment: .leading, spacing: 0) {
                                Text(value.primaryText)
                                if let secondary = value.secondaryText {
                                    Text(secondary)
                                        .font(.footnote)
                                        .foregroundColor(Color(uiColor: .systemGray))
                                }
                                Divider()
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                selection = value.primaryText
                                viewModel.makeSelection()
                                focused = false
                                onEvent?(.dropdownAction, ["action": "selection", "selectedItem": value.primaryText])
                            }
                        }
                        .padding(6)
                    }
                    .frame(minWidth: 200, minHeight: 200)
                }
        }
        .onTapGesture {
            if !viewModel.showDropdown {
                viewModel.filterList(value: selection)
                focused = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.viewModel.showDropdown = true
                    onEvent?(.dropdownAction, ["action": "opened", "currentSelection": selection])
                }
            }
        }
        .onChange(of: selection) { _, val in
            if val == " " && !allowBlank {
                selection = ""
            }
            if !viewModel.selected {
                viewModel.filterList(value: val)
            }
//            else {
//                focused = false
//            }
        }
        .onChange(of: focused) { _, _ in
            if !viewModel.showDropdown {
                if !focused {
                    endCheck()
                }
            }
            
            if sendKeyboardUpdate {
                NotificationCenter.default.post(name: Notification.Name("UI_Keyboard_Update"), object: focused)
            }
        }
        .onChange(of: viewModel.showDropdown) { _, show in
            if !show {
                endCheck()
            }
        }
    }
    
    var field: some View {
        TextField(placeHolder ?? "", text: $selection)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 20)
            .padding(6.0)
            .foregroundColor(Color(UIColor.label))
            .autocorrectionDisabled(true)
            .overlay (
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color((required && selection == "") ? UIColor.systemRed : UIColor.systemGray), lineWidth: (required && selection == "") ? 1.2 : 0.2)
            )
            .background(isEnabled ? Color(UIColor.systemBackground) : Color(UIColor.systemGray3).opacity(0.5))
            .cornerRadius(5)
            .focused($focused)
    }
    
    func endCheck() {
        viewModel.selected = false
        viewModel.showDropdown = false
        changed.toggle()
    }
}

//struct DropdownBlock_Previews: PreviewProvider {
//    static var previews: some View {
//        DropdownBlock(title: "Dropdown", values: [["54", "2"], ["31", "4"]], selection: .constant("22"), changed: .constant(false))
//    }
//}

//        .overlay(
//            VStack {
//                if viewModel.showDropdown {
//                    Spacer(minLength: 54)
//                    List {
//                        ForEach(viewModel.filteredValues, id: \.self) { value in
//                            VStack(alignment: .leading, spacing: 0) {
//                                Text("\(value[0])")
//                                if value.count > 1 && !value[1].isEmpty {
//                                    Text(value[1]).font(.footnote).foregroundColor(Color(uiColor: .systemGray))
//                                }
//                                Divider()
//                            }
//                            .listRowSeparator(.hidden)
//                            .contentShape(Rectangle())
//                            .onTapGesture {
//                                viewModel.makeSelectionWith(value[0])
//                                selection = viewModel.currentValue
//                                focused = false
//                            }
//                        }
//                    }
//                    .id(UUID())
//                    .padding(.top, 5)
//                    .listStyle(.plain)
//                    .overlay (
//                        RoundedRectangle(cornerRadius: 5)
//                            .stroke(Color(UIColor.systemGray), lineWidth: 0.2)
//
//                    )
//                    .frame(minHeight: 45 * CGFloat(viewModel.filteredValues.count <= 4 ? viewModel.filteredValues.count : 4))
//                    .background(Color(UIColor.systemBackground))
//                    .padding(.top, 5)
//                    .onChange(of: viewModel.filteredValues.count) { value in
//
//                    }
//                }
//            }, alignment: .topLeading
//
//        )

//    .popover(isPresented: $viewModel.showDropdown) {
//        List {
//            ForEach(viewModel.filteredValues, id: \.self) { value in
//                VStack(alignment: .leading, spacing: 0) {
//                    Text("\(value[0])")
//                    if value.count > 1 && !value[1].isEmpty {
//                        Text(value[1]).font(.footnote).foregroundColor(Color(uiColor: .systemGray))
//                    }
//                    Divider()
//                }
//                .listRowSeparator(.hidden)
//                .contentShape(Rectangle())
//                .onTapGesture {
//                    viewModel.makeSelectionWith(value[0])
//                    selection = viewModel.currentValue
//                    focused = false
//                }
//            }
//        }
//        .id(UUID())
//        .padding(.top, 5)
//        .listStyle(.plain)
//        .frame(width: 240)
//        .frame(minHeight: 45 * CGFloat(viewModel.filteredValues.count <= 4 ? viewModel.filteredValues.count : 4))
//        .background(Color(UIColor.systemBackground))
//        .padding(.top, 5)
//    }
