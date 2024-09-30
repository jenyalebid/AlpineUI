//
//  SidebarView.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 9/26/24.
//

import SwiftUI

public struct SidebarView<Selection: Hashable, Sidebar: View, Detail: View>: View {
    
    enum PresentationType {
        case push
        case overlay
    }
    
    @Environment(\.horizontalSizeClass) private var hSizeClass
    
    @Binding var selection: Selection
    @Binding var isExpanded: Bool
    
    @State private var dragOffset: CGFloat = 0
    @State private var startOffset: CGFloat = 0
    @State private var visiblePercentage: CGFloat = 0
    
    let effectiveWidth: CGFloat
    var width: CGFloat
    var gestureEnabled: Bool
    var sidebar: Sidebar
    var detail: Detail
    
    public init(selection: Binding<Selection>, isExpanded: Binding<Bool>,
                width: CGFloat = 300, gestureEnabled: Bool = true, @ViewBuilder sidebar: () -> Sidebar, @ViewBuilder detail: () -> Detail) {
        self._selection = selection
        self._isExpanded = isExpanded
        self.width = width
        self.effectiveWidth = width * 0.85
        self.gestureEnabled = gestureEnabled
        self.sidebar = sidebar()
        self.detail = detail()
    }

    public var body: some View {
        switch hSizeClass {
        case .regular:
            regularSidebarContent
        default:
            compactSidebarContent
        }
    }
    
    var compactSidebarContent: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                detail
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay {
                        if visiblePercentage > 0 {
                            Rectangle()
                                .fill(.black.opacity(0.50)).ignoresSafeArea()
                                .onTapGesture {
                                    withAnimation(.smooth(duration: 0.1)) {
                                        isExpanded.toggle()
                                    }
                                }
                        }
                    }
                
                if isExpanded || dragOffset != 0 {
                    sidebarContent(for: effectiveWidth)
                        .frame(width: effectiveWidth)
                        .offset(x: min(max(dragOffset + startOffset, -effectiveWidth), 0))
                }
            }
            .gesture(gestureEnabled ? dragGesture(for: effectiveWidth) : nil)
            .animation(.smooth(), value: isExpanded)
        }
        .onChange(of: isExpanded, initial: true) { _, newValue in
            withAnimation {
                visiblePercentage = newValue ? 1 : 0
                startOffset = newValue ? 0 : -effectiveWidth
                dragOffset = 0
            }
        }
    }
    
    var regularSidebarContent: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                if isExpanded || dragOffset != 0 {
                    sidebarContent(for: width)
                        .frame(width: width)
                        .offset(x: min(max(dragOffset + startOffset, -width), 0))
                        .gesture(gestureEnabled ? dragGesture(for: width) : nil)
                }
                
                detail
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .offset(x: isExpanded ? width : 0)
            }
            .animation(.smooth(), value: isExpanded)
        }
        .onChange(of: isExpanded, initial: true) { _, newValue in
            withAnimation {
                startOffset = newValue ? 0 : -width
                dragOffset = 0
            }
        }
    }
    
    func sidebarContent(for width: CGFloat) -> some View {
        sidebar
            .frame(width: width)
            .overlay(alignment: .trailing) {
                HStack {
                    Divider()
                }
                .ignoresSafeArea()
            }
            .offset(x: min(max(dragOffset + startOffset, -width), 0))
    }
    
    func dragGesture(for width: CGFloat) -> some Gesture {
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
