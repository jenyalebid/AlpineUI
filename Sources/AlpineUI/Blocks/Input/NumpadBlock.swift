//
//  NumpadBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/26/22.
//

import SwiftUI

public struct NumpadBlock<N>: View {
    
    @Environment(\.isEnabled) var isEnabled
    
    @Binding var value: N
    @Binding var changed: Bool
    
    @State private var textValue = ""
    @State private var showPad: Bool = false
    @State private var localValue = ""

    private let formatter = NumberFormatter()
    
    var title: String
    var required: Bool
    var limit: Double?
    
    public init(title: String, value: Binding<N>, limit: Double? = nil, required: Bool = false, changed: Binding<Bool>) {
        self.title = title
        self._value = value
        self.limit = limit
        self.required = required
        self._changed = changed
        formatter.numberStyle = .decimal
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("\(title):").font(.footnote)
            Group {
                if value is String {
                    TextField("", text: $textValue)
                }
                else {
                    TextField("", value: $value, formatter: formatter)
                }
            }
                .disabled(true)
                .padding(6.0)
                .overlay (
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color((required && value as? Double == 0) ? UIColor.systemRed : UIColor.systemGray), lineWidth: (required  && value as? Double == 0) ? 1.2 : 0.2)
                )
                .background(isEnabled ? Color(UIColor.systemBackground) : Color(UIColor.systemGray3).opacity(0.5))
                .cornerRadius(5)
                .popover(isPresented: $showPad) {
                    ZStack {
                        Color.accentColor
                            .scaleEffect(1.5)
                        KeypadView_Old(number: $localValue, size: UIScreen.main.bounds.size)
                            .onDisappear {
                                changed.toggle()
                            }
                    }
                    .onChange(of: localValue) { val in
                        if let limit {
                            guard Double(val) ?? 0 <= limit else{
                                return
                            }
                        }
                        if guardCheck(value: val) {
                            modify(val: val)
                        }
                    }
                    .onDisappear {
                        localValue = ""
                    }
                }
        }
        .onAppear {
            if value is String {
                textValue = value as! String
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            showPad.toggle()
        }
    }
    
    func guardCheck(value: String) -> Bool {
        if value == "delete" || value == "." {
            return false
        }
        
        var string = value.components(separatedBy: ".")
        if string.count > 2 {
            string.removeLast()
            string.insert(".", at: 1)
            modify(val: string.joined())
            return false
        }

        return true
    }
    
    func modify(val: String) {
        if value is String || value is String? {
            value = val as! N
            textValue = val
        }
        else {
            value = correctValue(formatter.number(from: val))
        }
    }

    func correctValue(_ number: NSNumber?) -> N {
        if let tempValue = number as? N {
            return tempValue
        }
        defer { 
            textValue = "" 
            localValue = ""
        }
        return NSNumber(0) as! N
    }
}

struct NumpadBlock_Previews: PreviewProvider {
    static var previews: some View {
        NumpadBlock(title: "Title", value: Binding.constant(""), changed: Binding.constant(false))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
