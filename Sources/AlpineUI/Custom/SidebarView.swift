//
//  SidebarView.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 9/26/24.
//

import SwiftUI

private struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        UIApplication.shared.keyWindow?.safeAreaInsets.swiftUiInsets ?? EdgeInsets()
    }
}

private extension UIEdgeInsets {
    var swiftUiInsets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}

public extension EnvironmentValues {
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}

public struct SidebarView<Selection: Hashable, Sidebar: View, Detail: View>: View {
    
    enum PresentationType {
        case push
        case overlay
    }
    
    @Environment(\.horizontalSizeClass) private var hSizeClass
    @Environment(\.safeAreaInsets) private var safeArea

    @Binding var selection: Selection
    @Binding var isExpanded: Bool
    
    @State private var dragOffset: CGFloat = 0
    @State private var startOffset: CGFloat = 0
    @State private var visiblePercentage: CGFloat = 0
    
    private var width: CGFloat
    
    var gestureEnabled: Bool
    var sidebar: Sidebar
    var detail: Detail
    
    @State private var currentOffset = 0
    
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
        .animation(.smooth(duration: 0.50), value: isExpanded)
    }
    
    var compactSidebarContent: some View {
        GeometryReader { geometry in
            let effectiveWidth = min((geometry.size.width * 0.85), width)
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
                sidebarContent(for: effectiveWidth)
                    .offset(x: min(max(dragOffset + startOffset, -effectiveWidth), 0))
            }
            .gesture(gestureEnabled ? dragGesture(for: effectiveWidth) : nil)
            .onChange(of: isExpanded, initial: true) { _, newValue in
                withAnimation {
                    visiblePercentage = newValue ? 1 : 0
                    startOffset = newValue ? 0 : -effectiveWidth
                    dragOffset = 0
                }
            }
        }
    }
    
    var regularSidebarContent: some View {
        GeometryReader { geometry in
            sidebarContent(for: width)
                .frame(width: width)
                .gesture(gestureEnabled ? swipeGesture : nil)
            detail
                .padding(.leading, isExpanded ? width : 0)
        }
    }
    
    func sidebarContent(for width: CGFloat) -> some View {
        sidebar
            .frame(width: width)
            .overlay(alignment: .trailing) {
                HStack {
                    Divider()
                        .padding(.top, safeArea.top)
                }
                .ignoresSafeArea()
            }
            .offset(x: isExpanded ? 0 : -width)
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
    
    var swipeGesture: some Gesture {
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
