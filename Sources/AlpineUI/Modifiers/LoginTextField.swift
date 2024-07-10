//
//  LoginTextField.swift
//  
//
//  Created by Vladislav on 7/10/24.
//

import SwiftUI

struct LoginTextField: ViewModifier {
    
    let color: Color = .gray
    let padding: CGFloat = 6
    let lineWidth: CGFloat = 0
    
    var placeholder: String
    
    @Binding var value: String
    
    func body(content: Content) -> some View {
        content
            .padding(padding)
            .overlay(RoundedRectangle(cornerRadius: padding)
                .stroke(color, lineWidth: lineWidth)
            )
            .modifier(PlaceholderStyle(showPlaceHolder: value.isEmpty, placeholder: placeholder))
            .frame(height: 40)
            .frame(maxWidth: 400, alignment: .center)
            .background(Color.white)
            .foregroundColor(Color.black)
            .cornerRadius(10)
    }
}



