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
                    .keyboardAdaptive()
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

extension View {
    public func popup<T: View>(isPresented: Binding<Bool>, alignment: Alignment = .center, direction: Alignment = .bottom, @ViewBuilder content: () -> T) -> some View {
        return modifier(Popup(isPresented: isPresented, alignment: alignment, direction: direction, content: content))
    }
}

private extension View {
    func onGlobalFrameChange(_ onChange: @escaping (CGRect) -> Void) -> some View {
        background(GeometryReader { geometry in
            Color.clear.preference(key: FramePreferenceKey.self, value: geometry.frame(in: .global))
        })
        .onPreferenceChange(FramePreferenceKey.self, perform: onChange)
    }

    func print(_ varargs: Any...) -> Self {
        Swift.print(varargs)
        return self
    }
}

private struct FramePreferenceKey: PreferenceKey {
    static let defaultValue = CGRect.zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

private extension View {
    @ViewBuilder func applyIf<T: View>(_ condition: @autoclosure () -> Bool, apply: (Self) -> T) -> some View {
        if condition() {
            apply(self)
        } else {
            self
        }
    }
}
