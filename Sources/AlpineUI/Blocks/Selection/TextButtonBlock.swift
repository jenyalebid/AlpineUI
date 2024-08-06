//
//  TextButtonBlock.swift
//  
//
//  Created by Jenya Lebid on 9/7/22.
//

import SwiftUI

public struct TextButtonBlock<Destination: View>: View {
    
    @State private var destinationActive = false
    
    private var image: String?
    private var text: String?
    private var height: CGFloat?
    private var width: CGFloat?
    private var foreground: Color
    private var background: Color
    private var font: Font
    private var action: (() -> ())?
    private var destination: () -> Destination
    private var eventTracker: UIEventTracker?
    
    public init(image: String? = nil, text: String? = nil, width: CGFloat? = nil, height: CGFloat? = nil, foreground: Color = .white, background: Color = .accentColor, font: Font = .body, eventTracker: UIEventTracker? = nil, action: (() -> ())? = nil, @ViewBuilder destination: @escaping () -> Destination = {EmptyView()}) {
        self.image = image
        self.text = text
        self.width = width
        self.height = height
        self.foreground = foreground
        self.background = background
        self.font = font
        self.action = action
        self.destination = destination
        self.eventTracker = eventTracker
    }
    
    public var body: some View {
        Button {
            eventTracker?.logUIEvent(.textButton, parameters: ["text": text ?? ""])
            if let action {
                action()
            }
            if hasDestination {
                destinationActive.toggle()
                eventTracker?.logUIEvent(.navigationLinkActivated, parameters: ["destination": String(describing: Destination.self)])
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
        HStack {
            TextButtonBlock(text: "Hello", background: .red, destination:  {
                
            })
            TextButtonBlock(image: "person", height: 41, destination:  {
                
            })
        }
    }
}
