//
//  DropdownBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/3/22.
//

import SwiftUI

public struct DropdownBlock: View {
        
    @Environment(\.isEnabled) var isEnabled
    
    var title: String
    var controlField: Bool
    var required: Bool
    
    @Binding var selection: String
    @Binding var changed: Bool
    
    @FocusState private var focused: Bool
    @StateObject var viewModel: DropdownViewModel
    
    public init(title: String, values: [PickerOption], selection: Binding<String>, required: Bool = false, controlField: Bool = false, changed: Binding<Bool>) {
        self.title = title
        self._selection = selection
        self.required = required
        self.controlField = controlField
        self._changed = changed
        
        _viewModel = StateObject(wrappedValue: DropdownViewModel(values: values))
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("\(title):").font(.footnote)
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.viewModel.showDropdown = true
                }
            }
        }
        .onChange(of: selection) { val in
            if !viewModel.selected {
                viewModel.filterList(value: val)
            }
            else {
                focused = false
            }
        }
        .onChange(of: focused) { _ in
            if !viewModel.showDropdown {
                if !focused {
                    endCheck()
                }
            }
        }
        .onChange(of: viewModel.showDropdown) { show in
            if !show {
                endCheck()
            }
        }
    }
    
    var field: some View {
        TextField("", text: $selection)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 20)
            .padding(6.0)
            .foregroundColor(Color(UIColor.label))
            .autocorrectionDisabled(true)
            .overlay (
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color((required && selection == "") ? UIColor.systemRed : UIColor.systemGray), lineWidth: (required && selection == "") ? 1.2 : 0.2)
            )
            .background(isEnabled ? Color(UIColor.systemGray6).opacity(0.5) : Color(UIColor.systemGray3).opacity(0.5))
            .cornerRadius(5)
            .focused($focused)
    }
    
    func endCheck() {
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
