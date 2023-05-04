//
//  SlideGestureModifier.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 11/7/22.
//

import SwiftUI

public struct SlideGestureModifier: ViewModifier {
    
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel: SlideGestureViewModel
    
    @Binding var show: Bool
    
    public init(show: Binding<Bool>, alignment: Alignment, allowMovement: Bool) {
        self._show = show
        
        _viewModel = StateObject(wrappedValue: SlideGestureViewModel(alignmnet: alignment, allowMovement: allowMovement))
    }
    
    public func body(content: Content) -> some View {
        content
            .offset(x: viewModel.xOffset, y: viewModel.yOffset)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: viewModel.alignmnet)
            .transition(.move(edge: viewModel.slideEdge))
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if viewModel.allowMovement {
                            viewModel.movementChange(value: value)
                        }
                    }
                    .onEnded { value in
                        if viewModel.greaterOrLessThan(first: value.location, second: value.startLocation) {
                            withAnimation {
                                show.toggle()
                            }
                        }
                        else {
                            viewModel.xOffset = 0
                        }
                    }
            )
            .onAppear {
                viewModel.xOffset = 0
            }
    }
}

extension View {
    public func slideGesture(show: Binding<Bool>, alignment: Alignment, allowMovement: Bool = true) -> some View {
        return modifier(SlideGestureModifier(show: show, alignment: alignment, allowMovement: allowMovement))
    }
}
