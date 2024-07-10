//
//  SwiftUIView.swift
//  
//
//  Created by Vladislav on 7/10/24.
//

import SwiftUI

struct UpdatableModifier: ViewModifier {
    
    @State var localID = UUID()
    var id: String
    
    func body(content: Content) -> some View {
        content
            .id(localID)
            .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("View_Update"))) { id in
                guard let id = id.userInfo?.first?.value as? String else {
                    return
                }
                if id == self.id {
                    localID = UUID()
                }
            }
    }
}
