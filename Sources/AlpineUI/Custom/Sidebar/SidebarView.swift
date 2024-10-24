//
//  SidebarView.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 9/26/24.
//

import SwiftUI

public struct SidebarView<Selection: Hashable, Sidebar: View, Detail: View>: View {
    
    @State private var manager = SidebarManager()
    
    @Environment(\.horizontalSizeClass) private var hSizeClass
    @Environment(\.safeAreaInsets) private var safeArea

    @Binding var selection: Selection
    @Binding var isExpanded: Bool
    
    @State private var dragOffset: CGFloat = 0
    @State private var startOffset: CGFloat = 0
    @State private var visiblePercentage: CGFloat = 0
    @State private var currentOffset = 0
    
    private var width: CGFloat
    private var gestureEnabled: Bool
    private var sidebar: Sidebar
    private var detail: Detail
    
    public init(selection: Binding<Selection>, isExpanded: Binding<Bool>,
                width: CGFloat = 300, gestureEnabled: Bool = true, @ViewBuilder sidebar: () -> Sidebar, @ViewBuilder detail: () -> Detail) {
        self._selection = selection
        self._isExpanded = isExpanded
        self.width = width
        self.gestureEnabled = gestureEnabled
        self.sidebar = sidebar()
        self.detail = detail()
    }

    public var body: some View {
        Group {
            switch hSizeClass {
            case .regular:
                regularSidebarContent
            default:
                compactSidebarContent
            }
        }
        .animation(.smooth(), value: isExpanded)
        .environment(\.sidebar, manager)
    }
    
    private var compactSidebarContent: some View {
        GeometryReader { geometry in
            let effectiveWidth = min((geometry.size.width * 0.85), width)
            ZStack(alignment: .leading) {
                detail
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay(visibilityOverlay)
                    .overlay(overlayGesture(for: effectiveWidth), alignment: .leading)
                   
                sidebarContent(for: effectiveWidth)
                    .gesture(gestureEnabled ? swipeCloseGesture : nil)
                    .offset(x: min(max(dragOffset + startOffset, -effectiveWidth), 0))
            }
            .onChange(of: isExpanded, initial: true) { _, newValue in
                withAnimation {
                    visiblePercentage = newValue ? 1 : 0
                    startOffset = newValue ? 0 : -effectiveWidth
                    dragOffset = 0
                }
            }
        }
    }
    
    private var regularSidebarContent: some View {
        GeometryReader { geometry in
            sidebarContent(for: width)
                .frame(width: width)
                .gesture(gestureEnabled ? swipeCloseGesture : nil)
            detail
                .padding(.leading, isExpanded ? width : 0)
                .overlay(overlayGesture(for: width), alignment: .leading)
        }
    }
    
    @ViewBuilder
    private var visibilityOverlay: some View {
            if visiblePercentage > 0 {
                Rectangle()
                    .fill(.black.opacity(0.50))
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.smooth()) {
                            isExpanded.toggle()
                        }
                    }
            }
    }
    
    private func overlayGesture(for width: CGFloat) -> some View {
        Color.clear
            .frame(width: 10)
            .contentShape(Rectangle())
            .gesture(swipeOpenGesture(for: width))
    }
    
    private func sidebarContent(for width: CGFloat) -> some View {
        sidebar
            .frame(width: width)
            .overlay(alignment: .trailing) {
                if manager.showDivider {
                    HStack {
                        Divider()
                            .padding(.top, manager.dividerPaddingTop ? safeArea.top : 0)
                            .padding(.bottom, manager.dividerPaddingBottom ? safeArea.bottom : 0)
                    }
                    .ignoresSafeArea()
                }
            }
            .offset(x: isExpanded ? 0 : -width)
    }
    
    private var swipeCloseGesture: some Gesture {
        DragGesture(minimumDistance: 50, coordinateSpace: .local)
            .onEnded { value in
                let horizontalAmount = value.translation.width as CGFloat
                let verticalAmount = value.translation.height as CGFloat
                if abs(horizontalAmount) > abs(verticalAmount) {
                    withAnimation {
                        isExpanded = horizontalAmount > 0
                    }
                }
            }
    }
    
    private func swipeOpenGesture(for width: CGFloat) -> some Gesture {
        DragGesture()
            .onChanged { value in
                if value.translation.width > 0 {
                    dragOffset = value.translation.width
                }
            }
            .onEnded { value in
                withAnimation(.smooth()) {
                    if value.translation.width > width / 2 {
                        isExpanded = true
                        startOffset = 0
                    }
                    dragOffset = 0
                }
            }
    }
    
    private func dragGesture(for width: CGFloat) -> some Gesture {
        DragGesture()
            .onChanged { value in
                dragOffset = value.translation.width
                
                let dragDistance = value.translation.width + startOffset
                visiblePercentage = 1 - (-dragDistance / width)
            }
            .onEnded { value in
                let dragDistance = value.translation.width + startOffset
                visiblePercentage = 1 - (-dragDistance / width)

                withAnimation(.smooth()) {
                    if visiblePercentage > 0.70 {
                        isExpanded = true
                        startOffset = 0
                    } else {
                        visiblePercentage = 0
                        isExpanded = false
                        startOffset = -width
                    }
                }
                dragOffset = 0
            }
    }
}

#Preview {
    SidebarPreview()
}

fileprivate struct SidebarPreview: View {
    
    @State private var selection = 1
    @State private var isExpanded = true
    
    var body: some View {
        SidebarView(selection: $selection, isExpanded: $isExpanded) {
            NavigationStack {
                List {
                   NavigationLink {
                        Text("HI")
                    } label: {
                        Label("Map", systemImage: "map")
                    }
                }
                .navigationTitle("Sidebar")
                .toolbar(content: {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            withAnimation {
                                isExpanded.toggle()
                            }
                        } label: {
                            Image(systemName: "sidebar.left")
                        }
                    }
                })
            }
        } detail: {
            NavigationStack {
                List {
                    
                }
                .navigationTitle("Detail")
                .toolbar(content: {
                    if !isExpanded {
                        ToolbarItem(placement: .topBarLeading) {
                            Button {
                                withAnimation {
                                    isExpanded.toggle()
                                }
                            } label: {
                                Image(systemName: "sidebar.left")
                            }
                        }
                    }
                })
            }
        }
    }
}
