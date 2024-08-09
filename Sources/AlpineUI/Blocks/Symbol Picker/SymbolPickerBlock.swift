//
//  SymbolPickerBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 7/26/23.
//

import SwiftUI

public struct SymbolPickerBlock: View {
    
    @Binding var symbol: String
    
    @State private var isPresented = false
    
    private var title: String
    private var onEvent: ((UIEvent, [String: Any]?) -> Void)?
    
    public init(title: String, symbol: Binding<String>, onEvent: ((UIEvent, [String: Any]?) -> Void)? = nil) {
        self.title = title
        self._symbol = symbol
        self.onEvent = onEvent
    }
    
    public var body: some View {
        HStack {
            ListLabel(title)
            Spacer()
            Group {
                Image(systemName: symbol)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .frame(width: 34, height: 34, alignment: .center)
            .simultaneousGesture(
                TapGesture()
                    .onEnded {
                        isPresented.toggle()
                    }
            )
            .popover(isPresented: $isPresented) {
                SymbolPickerView(title: title, symbol: $symbol, symbolsSet: .map, onEvent: { event, parameters in
                    onEvent?(event, parameters)
                })
                    .frame(minWidth: 300, idealWidth: 500, maxWidth: .infinity, minHeight: 400, idealHeight: 500, maxHeight: .infinity)
                    .overlay(
                        DismissButton(onEvent: { event, parameters in
                            onEvent?(event, parameters)
                        })
                            .padding(6),
                        alignment: .topTrailing
                    )
            }
        }
    }
}

struct SymbolPickerBlock_Previews: PreviewProvider {
    static var previews: some View {
        SymbolPickerBlock(title: "Symbol Pick", symbol: .constant("trash"))
    }
}

