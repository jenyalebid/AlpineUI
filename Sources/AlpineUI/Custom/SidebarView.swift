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
    var width: CGFloat
    
    var sidebar: Sidebar
    var detail: Detail
    
    public init(selection: Binding<Selection>, isExpanded: Binding<Bool>, 
                width: CGFloat = 300, @ViewBuilder sidebar: () -> Sidebar, @ViewBuilder detail: () -> Detail) {
        self._selection = selection
        self._isExpanded = isExpanded
        self.width = width
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
            let width = geometry.size.width * 0.80
            detail
            if isExpanded {
                Rectangle()
                    .fill(.black.opacity(0.10)).ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isExpanded.toggle()
                        }
                    }
            }
            sidebarContent(for: width)

        }
        .animation(.smooth(duration: 0.50), value: isExpanded)
    }
    
    var regularSidebarContent: some View {
        GeometryReader { geometry in
            sidebarContent(for: width)
            detail
                .padding(.leading, isExpanded ? width : 0)
        }
        .animation(.smooth(duration: 0.50), value: isExpanded)
    }
    
    func sidebarContent(for width: CGFloat) -> some View {
        sidebar
            .frame(width: width)
            .overlay(alignment: .trailing) {
                HStack {
                    Divider()
//                        .opacity(isExpanded ? 1 : 0)
                }
                .ignoresSafeArea()
            }
            .offset(x: isExpanded ? 0 : -width)
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
