//
//  SaveEditImage.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/13/22.
//

import SwiftUI

public struct SaveEditImage: View {
    
    @Binding var changed: Bool
    
    public var body: some View {
        Image(systemName: changed ? "square.and.arrow.down" : "square.and.pencil")
            .frame(width: 20)
            .font(changed ? .system(size: 17.5) : .system(size: 17))
            .offset(x: 0, y: changed ? -2.5 : -1)
    }
}

struct SaveEditImage_Previews: PreviewProvider {
    static var previews: some View {
        SaveEditImage(changed: Binding.constant(false))
    }
}
