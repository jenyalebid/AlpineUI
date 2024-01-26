//
//  SingleDropdownBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/3/22.
//

import SwiftUI

public struct SingleDropdownBlock: View {
    
    @Environment(\.isEnabled) var isEnabled
    @StateObject var viewModel: PickerViewModel
    
    var title: String
    var required: Bool
    
    @Binding var selection: String
    @Binding var changed: Bool
    
    @State private var show = false
    
    public init(title: String, values: [PickerOption], selection: Binding<String>, required: Bool = false, changed: Binding<Bool>) {
        self.title = title
        self._selection = selection
        self.required = required
        self._changed = changed
        
        _viewModel = StateObject(wrappedValue: PickerViewModel(selection: selection.wrappedValue, values: values))
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            if title != "" {
                Text("\(title):").font(.footnote)
            }
            field
                .popover(isPresented: $show) {
                    ScrollView {
                        ForEach(viewModel.values) { value in
                            Button {
                                viewModel.selection = value.primaryText
                                selection = viewModel.selection
                                show.toggle()
                            } label: {
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("\(value.primaryText)")
                                        .foregroundColor(selection == value.primaryText ? Color.accentColor : Color(uiColor: .label))
                                    if let secondary = value.secondaryText {
                                        Divider()
                                            .frame(width: 20)
                                            .padding(.bottom, 2)
                                        Text(secondary)
                                            .font(.footnote)
                                            .foregroundColor(Color(uiColor: .systemGray))
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(8)
                            }
                        }
                    }
                }
        }
        .onChange(of: selection) { _ in
            changed.toggle()
        }
        .onTapGesture {
            show.toggle()
        }
    }
    
    var field: some View {
        Text("\(viewModel.selection)")
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 20)
            .padding(6.0)
            .foregroundColor(Color(UIColor.label))
            .overlay (
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color((required && selection == "") ? UIColor.systemRed : UIColor.systemGray), lineWidth: (required && selection == "") ? 1.2 : 0.2)
            )
            .background(isEnabled ? Color(UIColor.systemBackground) : Color(UIColor.systemGray3).opacity(0.5))
            .cornerRadius(5)
    }
}

//struct SingleDropdownBlock_Previews: PreviewProvider {
//    static var previews: some View {
//        SingleDropdownBlock(title: "Dropdown", values: [["112313", "232323", "3434234"], ["43434344", "523433", "65345"], ["7234234", "8234444", "54549"], ["12342340", "11111", "11232"]], selection: .constant("1"), changed: .constant(false))
//    }
//}
