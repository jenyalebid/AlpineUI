//
//  ListNotifierBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 7/31/23.
//

import SwiftUI

public struct ListNotifierBlock: View {
    
    private var image: Image
    private var description: String
    private var height: CGFloat
    
    public init(description: String, height: CGFloat = 100, image: Image) {
        self.description = description
        self.height = height
        self.image = image
    }
    
    public var body: some View {
        VStack {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0.75)
            Text(description)
                .foregroundColor(Color(uiColor: .systemGray))
                .fontWeight(.semibold)
                .font(.caption)

        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .center)
        .frame(height: height)
    }
}

struct ListNotifierBlock_Previews: PreviewProvider {
    static var previews: some View {
        ListNotifierBlock(description: "Test", image: Image(systemName: "trash"))
    }
}
