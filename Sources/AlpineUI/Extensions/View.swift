//
//  View.swift
//
//
//  Created by Vladislav on 7/10/24.
//

import SwiftUI

public extension View {
    
    var shakeOnTap: some View {
        modifier(ShakeEffect())
    }
    
    func blinkEffect(minimum: Double = 0, maximum: Double = 1) -> some View {
        modifier(BlinkEffect(minimum: minimum, maximum: maximum))
    }
    
    func wiggle(interval: TimeInterval) -> some View {
        modifier(WiggleEffect(interval: interval))
    }
    
    func requiredOutline(_ isRequired: Bool, padding: CGFloat = 0) -> some View {
        modifier(RequiredViewModifier(isRequired: isRequired, padding: padding))
    }
    
    func panel(isPresented: Binding<Bool>, alignment: Alignment) -> some View {
        modifier(PanelModifier(isPresented: isPresented, alignment: alignment))
    }
    
    func loginField(placeholder: String, value: Binding<String>) -> some View {
        self.modifier(LoginTextField(placeholder: placeholder, value: value))
    }
    
    func onWillDisappear(_ perform: @escaping () -> Void) -> some View {
        modifier(WillDisappearModifier(callback: perform))
    }
    
    func listItemBackGround(id: UUID?, showSelected: Bool = true) -> some View {
        modifier(ListItemBGSelectModifier(id: id, showSelected: showSelected))
    }
    
    func draggable(isPresented: Binding<Bool>, alignment: Alignment) -> some View {
        modifier(DraggableModifier(isPresented: isPresented, alignment: alignment))
    }
    
    var listSelector: some View {
        modifier(ListObjectSelectorModifier())
    }
    
    func popup<T: View>(isPresented: Binding<Bool>, alignment: Alignment = .center, direction: Alignment = .bottom, @ViewBuilder content: () -> T) -> some View {
        modifier(Popup(isPresented: isPresented, alignment: alignment, direction: direction, content: content))
    }
    
    func slideGesture(show: Binding<Bool>, alignment: Alignment, allowMovement: Bool = true) -> some View {
        modifier(SlideGestureModifier(show: show, alignment: alignment, allowMovement: allowMovement))
    }
    
    func updateable(_ id: String) -> some View {
        modifier(UpdatableModifier(id: id))
    }
    
    func selectable(for id: UUID?) -> some View {
        modifier(SelectionModifier(guid: id))
    }
    
    @available(iOS 16.0, *)
    func navigationWithDimiss(isPresented: Binding<Bool>, alignment: ToolbarItemPlacement) -> some View {
        modifier(NavigationWithDismiss(isPresented: isPresented, dismissAlignmenet: alignment))
    }
    
    func keyboardAdaptive() -> some View {
        ModifiedContent(content: self, modifier: KeyboardAdaptive())
    }
    
    func onEdgeSwipe(edge: UIRectEdge, perform action: @escaping () -> Void) -> some View {
        self.overlay(EdgeSwipeGestureModifier(edge: edge, onRecognized: action))
    }
    
    func onGlobalFrameChange(_ onChange: @escaping (CGRect) -> Void) -> some View {
        background(GeometryReader { geometry in
            Color.clear.preference(key: FramePreferenceKey.self, value: geometry.frame(in: .global))
        })
        .onPreferenceChange(FramePreferenceKey.self, perform: onChange)
    }

    func resizableSheet<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        self.background(ResizeableSheet(show: isPresented, content: content))
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
//    func print(_ varargs: Any...) -> Self {
//        Swift.print(varargs)
//        return self
//    }
    
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    @ViewBuilder func applyIf<T: View>(_ condition: @autoclosure () -> Bool, apply: (Self) -> T) -> some View {
        if condition() {
            apply(self)
        } else {
            self
        }
    }
}

private struct FramePreferenceKey: PreferenceKey {
    static let defaultValue = CGRect.zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
