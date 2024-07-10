//
//  PlaceholderStyle 2.swift
//  
//
//  Created by Vladislav on 7/10/24.
//

import SwiftUI

public struct PlaceholderStyle: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: String

    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                Text(placeholder)
                .padding(.horizontal, 10)
                .foregroundColor(Color.gray)
                .font(.callout)
            }
            content
            .foregroundColor(Color.black)
            .padding(5.0)
        }
    }
}
