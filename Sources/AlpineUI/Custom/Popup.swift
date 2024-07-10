//
//  Popup.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/3/22.
//

import SwiftUI

public struct Popup<T: View>: ViewModifier, KeyboardReadable {
    
    let popup: T
    let alignment: Alignment
    let direction: Alignment
    let d = Direction.top
    
    @Binding var isPresented: Bool

    public init(isPresented: Binding<Bool>, alignment: Alignment, direction: Alignment, @ViewBuilder content: () -> T) {
        self._isPresented = isPresented
        self.alignment = alignment
        self.direction = direction
        popup = content()
    }

    public func body(content: Content) -> some View {
        content
            .overlay {
                popupContent()
            }
    }

    @ViewBuilder
    private func popupContent() -> some View {
        GeometryReader { geometry in
            if isPresented {
                popup
                    .slideGesture(show: $isPresented, alignment: direction)
                    .cornerRadius(10)
                    .padding()
//                    .animation(.spring(), value: isPresented)
//                    .transition(.offset(x: 0, y: d.offset(popupFrame: geometry.frame(in: .global))))
//                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: alignment)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
//                    .keyboardAdaptive()
            }
        }
    }
}

public enum Direction {
    case top, bottom

    func offset(popupFrame: CGRect) -> CGFloat {
        switch self {
        case .top:
            let aboveScreenEdge = -popupFrame.maxY
            return aboveScreenEdge
        case .bottom:
            let belowScreenEdge = UIScreen.main.bounds.height - popupFrame.minY
            return belowScreenEdge
        }
    }
}
