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

    var title: String
    var valueRange: ClosedRange<Double>
    var valueType: ValueType

    public init(title: String, min: Int, max: Int, value: Binding<Int>) {
        self.title = title
        self.valueRange = Double(min)...Double(max)
        self.valueType = .int(value)
    }

    public init(title: String, min: Double, max: Double, value: Binding<Double>) {
        self.title = title
        self.valueRange = min...max
        self.valueType = .double(value)
    }

    public init(title: String, min: Float, max: Float, value: Binding<Float>) {
        self.title = title
        self.valueRange = Double(min)...Double(max)
        self.valueType = .float(value)
    }

    public var body: some View {
        GeometryReader { geometry in
            HStack {
                ListLabel(title)
                    .frame(width: geometry.size.width / 3, alignment: .leading)
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
                   in: valueRange)
        case let .double(value):
            Slider(value: value, in: valueRange)
        case let .float(value):
            Slider(value: Binding<Double>(get: { Double(value.wrappedValue) },
                                          set: { value.wrappedValue = Float($0) }),
                   in: valueRange)
        }
    }
}

struct ListSliderBlock_Previews: PreviewProvider {
    static var previews: some View {
        ListSliderBlock(title: "Slider", min: 0, max: 100, value: .constant(50))
    }
}
