//
//  NavigationWithDismiss.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 6/5/23.
//

import SwiftUI

@available(iOS 16.0, *)
struct NavigationWithDismiss: ViewModifier {
    
    @Binding var isPresented: Bool
    var dismissAlignmenet: ToolbarItemPlacement
    
    func body(content: Content) -> some View {
        NavigationStack {
            content
                .toolbar {
                    ToolbarItem(placement: dismissAlignmenet) {
                        Button {
                            withAnimation {
                                isPresented.toggle()
                            }
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.red)
                        }
                    }
                }
        }
    }
}

public extension View {
    
    @available(iOS 16.0, *)
    func navigationWithDimiss(isPresented: Binding<Bool>, alignment: ToolbarItemPlacement) -> some View {
        modifier(NavigationWithDismiss(isPresented: isPresented, dismissAlignmenet: alignment))
    }
}
