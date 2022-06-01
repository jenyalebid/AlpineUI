//
//  NumpadBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/26/22.
//

import SwiftUI

public struct NumpadBlock<N>: View {
    
    @Environment(\.isEnabled) var isEnabled
    
    var title: String
    let formatter = NumberFormatter()
    
    @Binding var value: N
    @Binding var changed: Bool
    
    @State private var showPad = false
    @State private var localValue = ""
    
    public init(title: String, value: Binding<N>, changed: Binding<Bool>) {
        self.title = title
        self._value = value
        self._changed = changed
        formatter.zeroSymbol = ""
        formatter.numberStyle = .decimal
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("\(title):").font(.footnote)
            TextField("", value: $value, formatter: formatter)
                .disabled(true)
                .padding(6.0)
                .overlay (
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(UIColor.systemGray), lineWidth: 0.2)
                )
                .background(isEnabled ? Color(UIColor.systemGray6).opacity(0.5) : Color(UIColor.systemGray3).opacity(0.5))
                .cornerRadius(5)
                .popover(isPresented: $showPad) {
                    ZStack {
                        Color.accentColor
                            .scaleEffect(1.5)
                        KeypadView(number: $localValue, size: UIScreen.main.bounds.size)
                            .onDisappear {
                                changed.toggle()
                            }
                    }
                }
        }
//        .onAppear {
//            if value as! Double != 0.0 {
//                localValue = "\(value)"
//            }
//        }
        .onTapGesture {
            showPad.toggle()
        }
        .onChange(of: localValue) { val in
            if val != "delete" {
                value = formatter.number(from: val) as! N
            }
        }
    }
}

struct NumpadBlock_Previews: PreviewProvider {
    static var previews: some View {
        NumpadBlock(title: "Title", value: Binding.constant(""), changed: Binding.constant(false))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
