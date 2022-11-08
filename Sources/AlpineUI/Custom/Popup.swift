//
//  Popup.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/3/22.
//

import Combine
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
                    .onReceive(keyboardPublisher) { visible in
                        print(visible)
                    }
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

struct KeyboardAdaptive: ViewModifier {
    @State private var keyboardHeight: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight)
            .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0 }
    }
}

extension View {
    func keyboardAdaptive() -> some View {
        ModifiedContent(content: self, modifier: KeyboardAdaptive())
    }
}

extension Publishers {
    // 1.
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        // 2.
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { $0.keyboardHeight }
        
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
        
        // 3.
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}

extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}
