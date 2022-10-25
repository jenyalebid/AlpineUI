//
//  SingleDropdownBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/3/22.
//

import SwiftUI

public struct SingleDropdownBlock: View {
    
    @Environment(\.isEnabled) var isEnabled
    
    @ObservedObject var viewModel: PickerViewModel
    
    var title: String
    var values: [[String]]
    var required: Bool
    
    @Binding var selection: String
    @Binding var changed: Bool
    
    @State private var show = false
    
    public init(title: String, values: [[String]], selection: Binding<String>, required: Bool = false, changed: Binding<Bool>) {
        self.title = title
        self.values = values
        self._selection = selection
        self.required = required
        self._changed = changed
        
        self.viewModel = PickerViewModel(selection: selection.wrappedValue)
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("\(title):").font(.footnote)
            field
                .popover(isPresented: $show) {
                    ScrollView {
                        ForEach(values, id: \.self) { value in
                            Button {
                                viewModel.selection = value.count > 1 ? value[1] : value[0]
                                selection = viewModel.selection
                                show.toggle()
                            } label: {
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("\(value[0])")
                                        .foregroundColor(selection == value[0] ? Color.accentColor : Color(uiColor: .label))
                                    if value.count > 2 && !value[2].isEmpty {
                                        Divider()
                                            .frame(width: 20)
                                            .padding(.bottom, 2)
                                        Text(value[2])
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
            .background(isEnabled ? Color(UIColor.systemGray6).opacity(0.5) : Color(UIColor.systemGray3).opacity(0.5))
            .cornerRadius(5)
    }
}

struct SingleDropdownBlock_Previews: PreviewProvider {
    static var previews: some View {
        SingleDropdownBlock(title: "Dropdown", values: [["112313", "232323", "3434234"], ["43434344", "523433", "65345"], ["7234234", "8234444", "54549"], ["12342340", "11111", "11232"]], selection: .constant("1"), changed: .constant(false))
    }
}
