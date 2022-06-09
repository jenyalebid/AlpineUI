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
            Menu {
                ForEach(values, id: \.self) { value in
                    Button("\(value.count > 1 ? value[1] : value[0])") {
                        viewModel.selection = value.count > 1 ? value[1] : value[0]
                        selection = viewModel.selection
                    }
                }
            } label: {
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
//            .onChange(of: viewModel.selection) { _ in
//                if required == true {
//                    if selection != "" {
//                        missingRequired = false
//                    }
//                    else {
//                        re = true
//                    }
//                }
//            }
        }
        .onChange(of: selection) { _ in
            changed.toggle()
        }
    }
}

//struct SingleDropdownBlock_Previews: PreviewProvider {
//    static var previews: some View {
//        SingleDropdownBlock(title: "Title", values: ["1", "2", "3"])
//    }
//}
