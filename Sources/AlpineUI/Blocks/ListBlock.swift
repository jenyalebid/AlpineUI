//
//  ListBlock.swift
//  AlpineAtlas
//
//  Created by Jenya Lebid on 5/5/23.
//

import SwiftUI

public struct ListBlock<Content: View>: View {
    
    @Environment(\.dismiss) var dismiss
    
    var content: Content
        
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        List {
            content
        }
        .listStyle(.grouped)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Label("Back", systemImage: "chevron.left")
                }
                .buttonBorderShape(.circle)
            }
        }
    }
}

struct ListBlock_Previews: PreviewProvider {
    static var previews: some View {
        ListBlock {
            
        }
    }
}
