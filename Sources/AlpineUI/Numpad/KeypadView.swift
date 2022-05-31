//
//  KeypadView.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/25/22.
//

import SwiftUI


struct KeypadView: View {
    
    @StateObject var viewModel = KeypadViewModel()
    
    @Binding var number: String
    
    var size: CGSize

    var body: some View {
        VStack {
            ForEach(viewModel.rows) { row in
                HStack {
                    ForEach(row.values) { value in
                        KeyView(value: value.value, number: $number, size: CGSize(width: 768, height: 1024))
                        
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
        KeypadView(number: Binding.constant("0"), size: UIScreen.main.bounds.size)
            .previewInterfaceOrientation(.landscapeRight)
    }
}
