//
//  TextButtonBlock.swift
//  
//
//  Created by Jenya Lebid on 9/7/22.
//

import SwiftUI

public struct TextButtonBlock<Destination: View>: View {
    
    var image: String?
    var text: String?
    var height: CGFloat?
    var width: CGFloat?
    var foreground: Color
    var background: Color
    var font: Font
    
    var action: (() -> ())?
    var destination: () -> Destination
    
    @State private var destinationActive = false

    
    public init(image: String? = nil, text: String? = nil, width: CGFloat? = nil, height: CGFloat? = nil, foreground: Color = .white, background: Color = .accentColor, font: Font = .body, action: (() -> ())? = nil, @ViewBuilder destination: @escaping () -> Destination = {EmptyView()}) {
        self.image = image
        self.text = text
        self.width = width
        self.height = height
        self.foreground = foreground
        self.background = background
        self.font = font
        self.action = action
        self.destination = destination
    }
    
    public var body: some View {
        Button {
            if let action {
                action()
            }
            if hasDestination {
                destinationActive.toggle()
            }
        } label: {
            HStack {
                if let image = image {
                    Image(systemName: image)
                }
                if let text = text {
                    Text(text)
                }
            }
            .font(font)
            .foregroundColor(foreground)
            .padding(10)
            .frame(width: width, height: height)
            .background(
                Group {
                    background
                    if hasDestination {
                        NavigationLink(destination: destination(), isActive: $destinationActive) {
                            EmptyView()
                        }
                    }
                }
            )
            .cornerRadius(10)
        }
    }
    
    var hasDestination: Bool {
        return !(destination is (() -> EmptyView))
    }
}

struct TextButtonBlock_Previews: PreviewProvider {
    static var previews: some View {
        TextButtonBlock(image: "person", font: .footnote, destination:  {
            
        })
    }
}
