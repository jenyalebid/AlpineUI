//
//  SwiftUIView.swift
//  AlpineUI
//
//  Created by Vladislav on 10/2/24.
//

import SwiftUI

struct KeypadView<N: Numeric & LosslessStringConvertible>: View {
    
    @Binding var value: N
    
    @State private var currentValue: String = "0"
    @State private var isDecimalMode = false

    var limit: Int?
    var isCompact: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 1) {
            
            if isCompact {
                resultBlock
            }
         
            VStack {
                ForEach(getKeyRows(), id: \.self) { row in
                    HStack {
                        ForEach(row) { key in
                            keyButton(for: key)
                        }
                    }
                }
            }
            .frame(width: 250, height: 300)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.regularMaterial)
        .cornerRadius(10)
        .onAppear {
            currentValue = String(describing: value)
        }
    }
    
    private var resultBlock: some View {
        Text(currentValue)
            .font(.largeTitle)
            .frame(height: 50)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            .padding(.horizontal)
    }
    
    private func keyButton(for key: Key) -> some View {
        Button(action: {
            handleKeyPress(key)
        }) {
            Text(key.label)
                .font(.largeTitle)
                .frame(width: 64, height: 64)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }

    private func getKeyRows() -> [[Key]] {
        var keys = [
            [Key(label: "7", value: .digit(7)), Key(label: "8", value: .digit(8)), Key(label: "9", value: .digit(9))],
            [Key(label: "4", value: .digit(4)), Key(label: "5", value: .digit(5)), Key(label: "6", value: .digit(6))],
            [Key(label: "1", value: .digit(1)), Key(label: "2", value: .digit(2)), Key(label: "3", value: .digit(3))],
            [Key(label: "0", value: .digit(0)), Key(label: "<", value: .delete)]
        ]
        
        if value is Double || value is Float {
            keys[3].insert(Key(label: ".", value: .decimalPoint), at: 0)
        }
        
        return keys
    }
    
    private func handleKeyPress(_ key: Key) {
        
        switch key.value {
        case .digit(let number):
            if limit == nil || currentValue.count < limit! {
                    if isDecimalMode {
                        currentValue.append(String(number))
                    } else {
                        if currentValue == "0" || currentValue == "0.0" {
                            currentValue = String(number)
                        } else {
                            currentValue.append(String(number))
                        }
                    }
                }
        case .decimalPoint:
            if !isDecimalMode && (value is Double || value is Float) {
                currentValue.append(".")
                isDecimalMode = true
            }
        case .delete:
            if !currentValue.isEmpty {
                currentValue.removeLast()
                if currentValue.isEmpty || currentValue == "0." {
                    currentValue = "0"
                    isDecimalMode = false
                }
            }
        }

        if let numericValue = N(currentValue) {
            value = numericValue
        }
    }
}


#Preview {
    KeypadViewPreview()
}

struct KeypadViewPreview: View {
    
    @State private var intValue: Int = 0
    @State private var doubleValue: Double = 0.0

    var body: some View {
        VStack {
            HStack {
                
                TextField("Int Input", value: $intValue, format: .number)
                    .keypad(value: $intValue, limit: 5)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text("Int: \(intValue)")
                    .font(.largeTitle)
                    .padding()
            }

            
            Text("Double: \(doubleValue)")
                .font(.largeTitle)
                .padding()

            TextField("Double Input", value: $doubleValue, format: .number)
                .keypad(value: $doubleValue, limit: 7)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
        }
        .padding()
    }
}
