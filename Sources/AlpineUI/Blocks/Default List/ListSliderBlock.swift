//
//  ListSliderBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 7/17/23.
//

import SwiftUI

public struct ListSliderBlock: View {

    enum ValueType {
        case int(Binding<Int>)
        case double(Binding<Double>)
        case float(Binding<Float>)
    }

    private var title: String
    private var valueRange: ClosedRange<Double>
    private var valueType: ValueType
    private var labelWidthPart = 3
    private var onEditingChanged: (() -> Void)?

    public init(title: String, min: Int, max: Int, value: Binding<Int>, labelWidthPart: Int = 3, onEditingChanged: (() -> Void)? = nil) {
        self.title = title
        self.valueRange = Double(min)...Double(max)
        self.valueType = .int(value)
        self.labelWidthPart = labelWidthPart
        self.onEditingChanged = onEditingChanged
    }

    public init(title: String, min: Double, max: Double, value: Binding<Double>, labelWidthPart: Int = 3, onEditingChanged: (() -> Void)? = nil) {
        self.title = title
        self.valueRange = min...max
        self.valueType = .double(value)
        self.labelWidthPart = labelWidthPart
        self.onEditingChanged = onEditingChanged
    }

    public init(title: String, min: Float, max: Float, value: Binding<Float>, labelWidthPart: Int = 3, onEditingChanged: (() -> Void)? = nil) {
        self.title = title
        self.valueRange = Double(min)...Double(max)
        self.valueType = .float(value)
        self.labelWidthPart = labelWidthPart
        self.onEditingChanged = onEditingChanged
    }

    public var body: some View {
        GeometryReader { geometry in
            HStack {
                ListLabel(title)
                    .frame(width: geometry.size.width / CGFloat(labelWidthPart), alignment: .leading)
                slider
            }
        }
    }

    @ViewBuilder
    private var slider: some View {
        switch valueType {
        case let .int(value):
            Slider(value: Binding<Double>(get: { Double(value.wrappedValue) },
                                          set: { value.wrappedValue = Int($0) }),
                   in: valueRange) { _ in onEditingChanged?() }
        case let .double(value):
            Slider(value: value, in: valueRange) { _ in onEditingChanged?() }
        case let .float(value):
            Slider(value: Binding<Double>(get: { Double(value.wrappedValue) },
                                          set: { value.wrappedValue = Float($0) }),
                   in: valueRange) { _ in onEditingChanged?() }
        }
    }
}

struct ListSliderBlock_Previews: PreviewProvider {
    static var previews: some View {
        ListSliderBlock(title: "Slider", min: 0, max: 100, value: .constant(50))
    }
}
