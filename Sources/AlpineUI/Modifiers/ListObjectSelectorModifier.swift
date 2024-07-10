//
//  ListObjectSelectorModifier.swift
//  
//
//  Created by Vladislav on 7/10/24.
//

import SwiftUI


struct ListObjectSelectorModifier: ViewModifier {
    func body(content: Content) -> some View {
        ScrollViewReader { value in
            content
                .onReceive(NotificationCenter.default.publisher(for: Notification.Name("ListItemSelect"))) { info in
                    if let id = info.userInfo?.first?.value as? UUID {
                        value.scrollTo(id, anchor: .center)
                    }
                }
        }
    }
}
