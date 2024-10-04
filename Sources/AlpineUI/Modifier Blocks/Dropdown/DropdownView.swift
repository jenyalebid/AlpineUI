//
//  DropdownView.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 10/3/24.
//

import SwiftUI

struct DropdownView<ItemLabel: View, Item: Identifiable>: View {
    
    var items: [Item]
    @Binding var selectedItem: Item?
    @ViewBuilder var itemLabel: (_ item: Item) -> ItemLabel
    
    var body: some View {
        List {
            ForEach(items) { item in
                itemLabel(item)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedItem = item
                    }
            }
        }
        .listStyle(.plain)
    }
}
