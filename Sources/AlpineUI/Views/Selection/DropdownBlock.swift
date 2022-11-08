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
    var values: [[String]]
    var controlField: Bool
    var required: Bool
    
    @Binding var selection: String
    @Binding var changed: Bool
    
    @FocusState private var focused: Bool
    
    @ObservedObject var viewModel: DropdownViewModel
    
    public init(title: String, values: [[String]], selection: Binding<String>, required: Bool = false, controlField: Bool = false, changed: Binding<Bool>) {
        self.title = title
        self.values = values
        self._selection = selection
        self.required = required
        self.controlField = controlField
        self._changed = changed
        
        self.viewModel = DropdownViewModel(values: values, currentValue: selection.wrappedValue)
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            TextFieldBlock(title: title, value: $viewModel.currentValue, changed: .constant(false))
                .simultaneousGesture(
                    TapGesture()
                        .onEnded {
                            if !viewModel.showDropdown {
                                viewModel.filterList()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    self.viewModel.showDropdown = true
                                }
                            }
                        }
                )
        }
        .popover(isPresented: $viewModel.showDropdown) {
            BetterList {
                ForEach(viewModel.filteredValues, id: \.self) { value in
                    VStack(alignment: .leading, spacing: 0) {
                        Text("\(value[0])")
                        if value.count > 1 && !value[1].isEmpty {
                            Text(value[1]).font(.footnote).foregroundColor(Color(uiColor: .systemGray))
                        }
                        Divider()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.makeSelectionWith(value[0])
                        selection = viewModel.currentValue
                        focused = false
                    }
                }
                .padding(6)
            }
            .frame(minWidth: 200, minHeight: 200)
        }
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
        DropdownBlock(title: "Dropdown", values: [["54", "2"], ["31", "4"]], selection: .constant("22"), changed: .constant(false))
    }
}

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
