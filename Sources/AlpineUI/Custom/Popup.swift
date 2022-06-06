//
//  Popup.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/3/22.
//

import SwiftUI

public struct Popup<T: View>: ViewModifier {
    
    @State var bgOpacity = 0.0
    
    let popup: T
    //    let alignment: Alignment
    let direction: Direction
    let isPresented: Bool
    
    public init(isPresented: Bool, direction: Direction, @ViewBuilder content: () -> T) {
        self.isPresented = isPresented
        //        self.alignment = alignment
        self.direction = direction
        popup = content()
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
                .background(Color(uiColor: .systemBackground))

            Color.black.opacity(bgOpacity).ignoresSafeArea()
            popupContent()
        }
    }
    
    @ViewBuilder
    private func popupContent() -> some View {
        GeometryReader { geometry in
            if isPresented {
                popup
                    .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 3)
                    .frame(width: 600, height: 200, alignment: .center)
                    .animation(.spring())
                    .transition(.offset(x: 0, y: direction.offset(popupFrame: geometry.frame(in: .global))))
            }
        }
        .onChange(of: isPresented) { _ in
            withAnimation {
                bgOpacity = bgOpacity == 0 ? 0.5 : 0
            }
        }
    }
}

public extension Popup {
    enum Direction {
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
}

extension View {
    func popup<T: View>(isPresented: Bool, direction: Popup<T>.Direction = .bottom, @ViewBuilder content: () -> T) -> some View {
        return modifier(Popup(isPresented: isPresented, direction: direction, content: content))
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
