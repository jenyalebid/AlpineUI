//
//  ListItemView.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 10/5/22.
//

import SwiftUI

public struct ListItemView<Content: View, Destination: View>: View {
    
    var longPressAction: () -> ()
    var tapAction: (() -> ())?
    var content: () -> Content
    var destination: () -> Destination
    
    @State private var isActive = false
    
    public init(longPressAction: @escaping () -> (), tapAction: (() -> ())? = nil, @ViewBuilder content: @escaping () -> Content, @ViewBuilder destination: @escaping () -> Destination = {EmptyView()}) {
        self.longPressAction = longPressAction
        self.tapAction = tapAction
        self.content = content
        self.destination = destination
    }
    public var body: some View {
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
                if let tapAction = tapAction {
                    tapAction()
                }
            }
            .onLongPressGesture(minimumDuration: 1) {
                longPressAction()
            }
    }
}

//struct ListItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListItemView() {
//            EmptyView()
//        }
//    }
//}
