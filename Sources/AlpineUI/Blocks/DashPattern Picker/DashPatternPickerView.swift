//
//  DashPatternPickerView.swift
//  AlpineUI
//
//  Created by mkv on 12/8/23.
//

import SwiftUI

struct DashPatternPickerView: View {
    
    private static let patterns = ["solid", "dash", "doubleDash"]
    
    private static let gridDimension: CGFloat = 64
    private static let backgroundColor = Color(UIColor.systemGroupedBackground)
    private static let unselectedItemBackgroundColor = Color(UIColor.systemBackground)
    private static let selectedItemBackgroundColor = Color.accentColor
    
    @Binding public var pattern: String
    
    var title: String
    
    @Environment(\.presentationMode) private var presentationMode
    
    init(title: String, pattern: Binding<String>) {
        self.title = title
        _pattern = pattern
    }

    var body: some View {
        NavigationView {
            ZStack {
                Self.backgroundColor.edgesIgnoringSafeArea(.all)
                patternGrid
                    .navigationTitle(title)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
    }
    
    private var patternGrid: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: Self.gridDimension, maximum: Self.gridDimension))]) {
                ForEach(Self.patterns, id: \.self) { thisPattern in
                    Button {
                        pattern = thisPattern
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        if thisPattern == pattern {
                            Image(systemName: "eye")
                                .frame(maxWidth: .infinity, minHeight: Self.gridDimension)
                                .background(Self.selectedItemBackgroundColor)
                                .foregroundColor(.white)
                        } else {
                            Image(systemName: "eye")
                                .frame(maxWidth: .infinity, minHeight: Self.gridDimension)
                                .background(Self.unselectedItemBackgroundColor)
                                .foregroundColor(.primary)
                        }
                    }
                    .buttonStyle(.plain)
                    .hoverEffect(.lift)
                }
            }
            .padding(.horizontal)
        }
    }
}
