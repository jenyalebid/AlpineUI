//
//  NavOpenerModifier.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 3/7/23.
//

import SwiftUI

public struct NavModifier<Navigator: NavHost>: ViewModifier {
    
    @ObservedObject var control = NavControl.shared
    @State var open = false
    @State var object: (any Viewable)? = nil
    
    var navigator: Navigator
    
    public init(@ViewBuilder navigator: () -> Navigator) {
        self.navigator = navigator()
    }
    
    public func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    menu
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name("Nav_Object_Open"))) { info in
                guard let object = info.object as? (any Viewable) else {
                    return
                }
                self.object = object
                open = true
            }
            .background(
                NavigationLink(isActive: $open, destination: {
                    Nav.host(object: object)
                }, label: {
                    EmptyView()
                })
            )
    }
    
    var menu: some View {
        Button {
            withAnimation(.easeIn) {
                control.sidebar.toggle()
            }
        } label: {
            Image(systemName: "sidebar.left")
        }
    }
    
    var back: some View {
        Button {
            withAnimation(.easeIn) {
                
            }
        } label: {
            Image(systemName: "chevron.backward")
        }
    }
}


