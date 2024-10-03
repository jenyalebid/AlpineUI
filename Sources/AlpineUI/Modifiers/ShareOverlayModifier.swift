//
//  ShareOverlayModifier.swift
//  AlpineAtlas
//
//  Created by Jenya Lebid on 5/17/24.
//

import SwiftUI

struct ShareOverlayModifier: ViewModifier {
    
    struct Triangle: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.closeSubpath()
            return path
        }
    }
    
    var isShared: Bool
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .topLeading) {
                if isShared {
                    Group {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 20)
                            .shadow(radius: 0.5)
                        Image(systemName: "person.2.wave.2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 14)
                            .foregroundColor(.white)
                    }
                    .offset(x: -5, y: -6)
                }
            }
    }
}


#Preview {
    List {
        HStack {
//            StorageItemImage(type: .folder)
            Text("Share Overlay Hello")
        }
        .shareOverlay(isShared: true)
    }
}
