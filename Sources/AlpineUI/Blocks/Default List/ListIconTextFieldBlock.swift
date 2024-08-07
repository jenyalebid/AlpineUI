//
//  SwiftUIView.swift
//  
//
//  Created by Vladislav on 8/7/24.
//

import SwiftUI

public struct ListIconTextFieldBlock: View {
    
    private var systemImage: String
    private var title: String
    
    public init(systemImage: String, title: String) {
        self.systemImage = systemImage
        self.title = title
    }
    
    public var body: some View {
        HStack {
            Image(systemName: systemImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20, alignment: .center)
                .padding(.trailing, 4)
            Text(title)
        }
    }
}
