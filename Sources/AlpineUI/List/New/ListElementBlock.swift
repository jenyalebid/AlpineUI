//
//  SwiftUIView.swift
//  
//
//  Created by Jenya Lebid on 5/23/23.
//

import SwiftUI

public struct ListElementBlock<Content: View, Menu: View, Destination: View>: View {
    
    var content: () -> Content
    
    var onTapGesture: (() -> ())?
    var destination: () -> Destination
    var contextMenu: () -> Menu
        
    var guid: UUID?
        
    @State private var isActive = false
    
    @ObservedObject var selection = SelectionManager.shared
    
    public init(guid: UUID?, @ViewBuilder content: @escaping () -> Content,
                onTapGesture: (() -> ())? = nil, @ViewBuilder contextMenu: @escaping () -> Menu = {EmptyView()},
                @ViewBuilder destination: @escaping () -> Destination = {EmptyView()}) {
        self.guid = guid
        self.content = content
        
        self.onTapGesture = onTapGesture
        self.contextMenu = contextMenu
        self.destination = destination
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            contentView
                .padding(.horizontal, 8)
                .padding(.vertical)
                .selectable(for: guid)
                .contextMenu {
                    contextMenu()
                }
            Divider()
        }
    }
    
    var contentView: some View {
        content()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .contentShape(Rectangle())
            .background(
                Group {
                    if !(destination is (() -> EmptyView)) {
                        NavigationLink(destination: destination(), isActive: $isActive) {
                            EmptyView()
                        }
                    }
                }
            )
            .onTapGesture {
                isActive.toggle()
                if let onTapGesture {
                    SelectionManager.select(guid)
                    onTapGesture()
                }
            }
    }
}
