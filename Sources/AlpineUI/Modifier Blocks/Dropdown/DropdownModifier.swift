//
//  SwiftUIView.swift
//  
//
//  Created by Jenya Lebid on 10/3/24.
//

import SwiftUI

struct DropdownModifier<ItemLabel: View, Item: Identifiable>: ViewModifier {
    
    @State private var showDropdown = false
    var items: [Item]
    @Binding var selectedItem: Item?
    var size: CGSize
    @ViewBuilder var itemLabel: (_ item: Item) -> ItemLabel
    
    func body(content: Content) -> some View {
        content
            .allowsTightening(false)
            .onTapGesture {
                showDropdown.toggle()
            }
            .popover(isPresented: $showDropdown, content: {
                DropdownView(items: items, selectedItem: $selectedItem, itemLabel: itemLabel)
                    .presentationBackground(.regularMaterial)
                    .presentationCompactAdaptation(.popover)
                    .frame(width: size.width, height: size.height)
            })
    }
}

public extension View {
    func dropdown<ItemLabel: View, Item: Identifiable>(for items: [Item], 
                                                       selected: Binding<Item?>,
                                                       size: CGSize = CGSize(width: 300, height: 300),
                                                       @ViewBuilder label: @escaping (_ item: Item) -> ItemLabel) -> some View {
        modifier(DropdownModifier(items: items, selectedItem: selected, size: size, itemLabel: label))
    }
}

