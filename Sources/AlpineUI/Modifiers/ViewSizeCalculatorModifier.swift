//
//  ViewSizeCalculatorModifier.swift
//  PopupKit
//
//  Created by Jenya Lebid on 8/31/23.
//

import SwiftUI

struct ViewSizeCalculatorModifier: ViewModifier {
    
    @Binding var size: CGSize
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            size = proxy.size
                        }
                }
            )
    }
}
