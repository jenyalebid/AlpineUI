////
////  PickerBlock.swift
////  AlpineUI
////
////  Created by Jenya Lebid on 4/29/22.
////
//
//import SwiftUI
//
//public struct PickerBlock: View {
//    
//    @Environment(\.isEnabled) var isEnabled
//    
//    @ObservedObject var viewModel: PickerViewModel
//    
//    var title: String
//    var values: [[String]]
//    var required: Bool
//    
//    @State var showPicker = false
//    
//    @Binding var selection: String
//    @Binding var changed: Bool
//    
//    public init(title: String, values: [[String]], selection: Binding<String> = Binding.constant(""), required: Bool = false, changed: Binding<Bool>) {
//        self.title = title
//        self.values = values
//        self._selection = selection
//        self.required = required
//        self._changed = changed
//        self.viewModel = PickerViewModel(selection: selection.wrappedValue, values: values)
//    }
//    
//    public var body: some View {
//        VStack(alignment: .leading, spacing: 2) {
//            Text("\(title):").font(.footnote)
//            Text("\(viewModel.selection)")
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .frame(height: 20)
//                .padding(6.0)
//                .foregroundColor(Color(UIColor.label))
//                .overlay (
//                    RoundedRectangle(cornerRadius: 5)
//                        .stroke(Color((required && selection == "") ? UIColor.systemRed : UIColor.systemGray), lineWidth: (required && selection == "") ? 1.2 : 0.2)
//                )
//                .onChange(of: selection) { _ in
//                    changed.toggle()
//                }
//                .popover(isPresented: $showPicker, content: {
//                    MultiSelectMenu(values: values, exisingSelections: $selection)
//                })
//                .background(isEnabled ? Color(UIColor.systemGray6).opacity(0.5) : Color(UIColor.systemGray3).opacity(0.5))
//                .cornerRadius(5)
//        }
//        .contentShape(Rectangle())
//        .onTapGesture {
//            showPicker.toggle()
//        }
//    }
//}
////
//////struct PickerBlock_Previews: PreviewProvider {
//////    static var previews: some View {
//////        PickerBlock(title: "Sample Title", values: ["Value 1", "Value 2", "Value 3"])
//////    }
//////}
