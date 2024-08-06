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
    private var eventTracker: UIEventTracker?
    
    public init(title: String, symbol: Binding<String>, eventTracker: UIEventTracker? = nil) {
        self.title = title
        self._symbol = symbol
        self.eventTracker = eventTracker
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
                SymbolPickerView(title: title, symbol: $symbol, symbolsSet: .map, eventTracker: eventTracker)
                    .frame(minWidth: 300, idealWidth: 500, maxWidth: .infinity, minHeight: 400, idealHeight: 500, maxHeight: .infinity)
                    .overlay(
                        DismissButton(eventTracker: eventTracker)
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
