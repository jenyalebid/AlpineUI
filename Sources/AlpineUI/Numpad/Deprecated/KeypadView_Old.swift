//
//  KeypadView.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/25/22.
//

import SwiftUI


@available(*, deprecated, message: "This is an deprecated object. Use KeypadModifier to display the Keypad.")
struct KeypadView_Old: View {
    
    @StateObject var viewModel = KeypadViewModel_Old()
    
    @Binding var number: String
    
    var size: CGSize

    var body: some View {
        VStack {
            ForEach(viewModel.rows) { row in
                HStack {
                    ForEach(row.values) { value in
                        KeyView_Old(value: value.label, number: $number, size: CGSize(width: 768, height: 1024))
                        
                    }
                }
            }
        }
        .frame(width: 256, height: 342)
        .cornerRadius(10)
    }
}

struct KeypadView_Previews: PreviewProvider {
    static var previews: some View {
        KeypadView_Old(number: Binding.constant("0"), size: UIScreen.main.bounds.size)
            .previewInterfaceOrientation(.landscapeRight)
    }
}
