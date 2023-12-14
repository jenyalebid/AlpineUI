//
//  FillPatternPickerView.swift
//  AlpineUI
//
//  Created by mkv on 12/8/23.
//

import SwiftUI

@available(iOS 17.0, *)
struct FillPatternPickerView: View {

    private static let patterns = ["solid", "crosshatch", "horizontal", "vertical", "rightDiagonal", "leftDiagonal"]

    private static let gridDimension: CGFloat = 80
    private static let viewCornerRadius: CGFloat = 8
    private static let unselectedItemBackgroundColor = Color(UIColor.systemBackground)
    private static let selectedItemBackgroundColor = Color.accentColor
    private static let backgroundColor = Color(UIColor.systemGroupedBackground)
    
    @State var hatchWidth: Int = 10
    @State var fillPercent: Int = 0

    @Binding public var pattern: String
    var patternView: FillPatternView
    
    var title: String
    
    @Environment(\.presentationMode) private var presentationMode

    init(title: String, pattern: Binding<String>, patternView: FillPatternView) {
        self.title = title
        _pattern = pattern
        self.patternView = patternView
    }

    private var patternGrid: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: Self.gridDimension, maximum: Self.gridDimension))]) {
                    ForEach(Self.patterns, id: \.self) { thisPattern in
                        Button {
                            pattern = thisPattern
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            if thisPattern == pattern {
                                patternView.getView(for: thisPattern, hatchWidth: hatchWidth, fillPercent: fillPercent)
                                    .frame(maxWidth: .infinity, minHeight: Self.gridDimension)
                                    .background(Self.selectedItemBackgroundColor)
                                    .cornerRadius(Self.viewCornerRadius)
                                    .foregroundColor(.white)
                            } else {
                                patternView.getView(for: thisPattern, hatchWidth: hatchWidth, fillPercent: fillPercent)
                                    .frame(maxWidth: .infinity, minHeight: Self.gridDimension)
                                    .background(Self.unselectedItemBackgroundColor)
                                    .cornerRadius(Self.viewCornerRadius)
                                    .foregroundColor(.primary)
                            }
                        }
                        .buttonStyle(.plain)
                        .hoverEffect(.lift)
                    }
                }
                .padding(.horizontal)
            }
            Group {
                ListSliderBlock(title: "Hatch Width", min: 20, max: 50, value: $hatchWidth)
                    .padding(.horizontal)
                ListSliderBlock(title: "Fill Percent", min: 0, max: 100, value: $fillPercent)
                    .padding(.horizontal)
            }
            .frame(maxHeight: 50)
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Self.backgroundColor.edgesIgnoringSafeArea(.all)
                patternGrid
                    .navigationTitle(title)
            }
            .toolbar {
                DismissButton()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
