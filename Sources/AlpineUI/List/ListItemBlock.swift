//
//  ListItemBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 10/5/22.
//

import SwiftUI

public struct ListItemBlock<Content: View, Destination: View>: View {
        
    var longPressAction: (() -> ())?
    var tapAction: (() -> ())?
    var content: () -> Content
    var destination: () -> Destination
    
    var guid: UUID?
    
    @State private var isActive = false
    
    public init(guid: UUID?, @ViewBuilder content: @escaping () -> Content, tapAction: (() -> ())? = nil, longPressAction: (() -> ())? = nil, @ViewBuilder destination: @escaping () -> Destination = {EmptyView()}) {
        self.guid = guid
        self.longPressAction = longPressAction
        self.tapAction = tapAction
        self.content = content
        self.destination = destination
    }
    public var body: some View {
        VStack(spacing: 0) {
            contentView
                .padding(8)
                .listItemBackGround(id: guid, showSelected: true)
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
                if let tapAction {
                    if let guid {
                        NotificationCenter.default.post(name: Notification.Name("ListItemSelect"), object: nil, userInfo: ["id": guid])
                        tapAction()
                    }
                }
            }
            .onLongPressGesture(minimumDuration: 1) {
                if let longPressAction {
                    if let guid {
                        NotificationCenter.default.post(name: Notification.Name("ListItemLongPress"), object: nil, userInfo: ["id": guid])
                        longPressAction()
                    }
                }
            }
    }
}

//struct ListItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListItemBlock() {
//            EmptyView()
//        }
//    }
//}
