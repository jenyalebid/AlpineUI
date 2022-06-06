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
    var values: [String]
    var controlField: Bool
    
    @Binding var selection: String
    @Binding var height: Double?
    @Binding var changed: Bool
    @Binding var required: Bool?
    
    @State var localRequired: Bool? = false
    
    @FocusState private var focused: Bool
    
    @ObservedObject var viewModel: DropdownViewModel
    
    public init(title: String, values: [String], selection: Binding<String>, height: Binding<Double?> = .constant(nil), required: Binding<Bool?>? = .constant(nil), controlField: Bool = false, changed: Binding<Bool>) {
        self.title = title
        self.values = values
        self._selection = selection
        self._height = height
        self._required = required ?? .constant(false)
        self.controlField = controlField
        self._changed = changed
        
        if required?.wrappedValue ?? false {
            localRequired = true
        }
        
        self.viewModel = DropdownViewModel(values: values, currentValue: selection.wrappedValue)
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            TextFieldBlock(title: title, value: $viewModel.currentValue, required: false, changed: $changed)
                .onTapGesture {
                    if !viewModel.showDropdown {
                        focused = true
                        viewModel.filterList()
                        viewModel.showDropdown = true
                    }
                }
                .focused($focused)
                .popover(isPresented: $viewModel.showDropdown) {
                    List {
                        ForEach(viewModel.filteredValues, id: \.self) { value in
                            VStack(alignment: .leading, spacing: 0) {
                                Text("\(value)")
                                Divider()
                            }
                            .listRowSeparator(.hidden)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                viewModel.makeSelectionWith(value)
                                selection = viewModel.currentValue
                                focused = false
                                required = localRequired
                            }
                        }
                    }
                    .id(UUID())
                    .padding(.top, 5)
                    .listStyle(.plain)
        //            .overlay (
        //                RoundedRectangle(cornerRadius: 5)
        //                    .stroke(Color(UIColor.systemGray), lineWidth: 0.2)
        //
        //            )
                    .frame(minWidth: 160, maxWidth: .infinity)
                    .frame(minHeight: 45 * CGFloat(viewModel.filteredValues.count <= 4 ? viewModel.filteredValues.count : 4))
                    .background(Color(UIColor.systemBackground))
                    .padding(.top, 5)
                    .onChange(of: viewModel.filteredValues.count) { value in
                        height = Double(value)
                    }
                }
        }
//        .overlay(
//            VStack {
//                if viewModel.showDropdown {
//                    Spacer(minLength: 54)
//                    List {
//                        ForEach(viewModel.filteredValues, id: \.self) { value in
//                            VStack(alignment: .leading, spacing: 0) {
//                                Text("\(value)")
//                                Divider()
//                            }
//                            .listRowSeparator(.hidden)
//                            .contentShape(Rectangle())
//                            .onTapGesture {
//                                viewModel.makeSelectionWith(value)
//                                selection = viewModel.currentValue
//                                focused = false
//                                required = localRequired
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
//                        height = Double(value)
//                    }
//                }
//            }, alignment: .topLeading
//
//        )
        .onChange(of: viewModel.currentValue) { val in
            if !viewModel.selected {
                viewModel.filterList()
            }
            if val == "" && controlField {
                viewModel.makeSelectionWith(val)
                selection = viewModel.currentValue
                focused = false
            }
        }
    }
}

struct DropdownBlock_Previews: PreviewProvider {
    static var previews: some View {
        DropdownBlock(title: "Dropdown", values: ["1", "22", "3", "4", "5"], selection: .constant("2"), changed: .constant(false))
    }
}
