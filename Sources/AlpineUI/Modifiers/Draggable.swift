//
//  Draggable.swift
//  ApineUI
//
//  Created by Jenya Lebid on 6/5/23.
//

import SwiftUI

struct DraggableModifier: ViewModifier {
    
    @Binding var isPresented: Bool
    @State private var translation: CGSize = .zero

    var alignment: Alignment
    let threshold: CGFloat = 100
    
    func body(content: Content) -> some View {
        content
            .offset(x: isHorizontal ? translation.width : 0,
                    y: !isHorizontal ? translation.height : 0)
            .animation(.spring(), value: translation)
            .transition(.move(edge: Edge(from: alignment)))
            .gesture(
                DragGesture(minimumDistance: 100)
                    .onChanged { value in
                        switch alignment {
                        case .top, .bottom:
                            if value.translation.height < threshold && value.translation.height > -threshold {
                                translation = CGSize(width: 0, height: value.translation.height)
                            }
                        case .leading, .trailing:
                            if value.translation.width < threshold && value.translation.width > -threshold {
                                translation = CGSize(width: value.translation.width, height: 0)
                            }
                        default:
                            break
                        }
                    }
                    .onEnded { value in
                        translation = .zero

                        switch alignment {
                        case .top:
                            if value.translation.height < -threshold {
                                withAnimation {
                                    isPresented = false
                                }
                            }
                        case .bottom:
                            if value.translation.height > threshold {
                                withAnimation {
                                    isPresented = false
                                }
                            }
                        case .leading:
                            if value.translation.width < -threshold {
                                withAnimation {
                                    isPresented = false
                                }
                            }
                        case .trailing:
                            if value.translation.width > threshold {
                                withAnimation {
                                    isPresented = false
                                }
                            }
                        default:
                            break
                        }
                    }
            )
    }

    var isHorizontal: Bool {
        switch alignment {
        case .leading, .trailing:
            return true
        default:
            return false
        }
    }

    func Edge(from alignment: Alignment) -> Edge {
        switch alignment {
        case .top:
            return .top
        case .bottom:
            return .bottom
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        default:
            return .bottom
        }
    }
}

public extension View {
    
    func draggable(isPresented: Binding<Bool>, alignment: Alignment) -> some View {
        self.modifier(DraggableModifier(isPresented: isPresented, alignment: alignment))
    }
}
