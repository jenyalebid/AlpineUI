//
//  Sidebar.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 2/14/23.
//

import SwiftUI

public struct Sidebar<SidebarContent: View, ControlContent: View, Content: View>: View {
    
    let sidebarContent: SidebarContent
    let controlContent: ControlContent
    let mainContent: Content
    let sidebarWidth: CGFloat
    
    @Binding var showSidebar: Bool
    
    public init(sidebarWidth: CGFloat, showSidebar: Binding<Bool>, @ViewBuilder sidebar: ()-> SidebarContent, @ViewBuilder controls: () -> ControlContent = {EmptyView()}, @ViewBuilder content: ()-> Content) {
        self.sidebarWidth = sidebarWidth
        self._showSidebar = showSidebar
        sidebarContent = sidebar()
        controlContent = controls()
        mainContent = content()
    }
    
    public var body: some View {
        ZStack(alignment: .leading) {
            mainContent
                .overlay(
                    Group {
                        if showSidebar {
                            Color.black
                                .opacity(0.50)
                                .onTapGesture {
                                    withAnimation() {
                                        showSidebar.toggle()
                                    }
                                }
                        }
                    }
                )
            HStack {
                HStack(spacing: 0) {
                    sidebarContent
                    Divider()
                }
                .frame(width: 300, alignment: .leading)
                controlContent
                    .frame(width: 60)
            }
            .overlay {
                if !showSidebar {
                    Color(uiColor: .systemBackground)
                }
            }
            .offset(x: showSidebar ? 0 : -370)
        }
    }
}

