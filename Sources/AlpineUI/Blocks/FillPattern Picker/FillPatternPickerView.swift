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
    
    @State var hatchWidth: Int = 10
    @State var fillPercent: Int = 0

    @Binding public var pattern: String
    var patternView: FillPatternView
    
    var title: String
    
    @Environment(\.dismiss) private var dismiss

    init(title: String, pattern: Binding<String>, patternView: FillPatternView) {
        self.title = title
        _pattern = pattern
        self.patternView = patternView
    }

    private var patternGrid: some View {
        List {
            Section {
                ListSliderBlock(title: "Hatch Width", min: 20, max: 50, value: $hatchWidth)
                ListSliderBlock(title: "Fill Percent", min: 0, max: 100, value: $fillPercent)
            } header: {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: Self.gridDimension, maximum: Self.gridDimension))]) {
                    ForEach(Self.patterns, id: \.self) { thisPattern in
                        Button {
                            pattern = thisPattern
                            dismiss()
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
                    }
                }
                .padding(.bottom)
            }
        }
        .listStyle(.insetGrouped)
    }

    var body: some View {
        NavigationStack {
            patternGrid
            .toolbar {
                DismissButton()
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
