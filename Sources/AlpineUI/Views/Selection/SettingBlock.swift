//
//  SettingBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 9/27/22.
//

import SwiftUI

public struct SettingBlock<Content: View, Destination: View>: View {
    
    var image: String
    var color: Color = .accentColor
    var title: String
    
    var displayContent: () -> Content
    var destination: () -> Destination
    var action: (() -> ())?
    
    @State var isActiveNavigation = false
    
    public init(image: String, color: Color = .accentColor, title: String, @ViewBuilder displayContent: @escaping () -> Content = {EmptyView()}, destination: @escaping (() -> Destination) = {EmptyView()}, action: (() -> ())? = nil) {
        self.image = image
        self.color = color
        self.title = title
        self.displayContent = displayContent
        self.destination = destination
        self.action = action
        
    }
    
    public var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke()
                    .frame(width: 34, height: 34)
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 16.0)
            }
            .padding(.trailing, 6)
            .foregroundColor(color)
            Text(title)
                .font(.headline)
                .fontWeight(.medium)
            Spacer()
            displayContent()
            if !(destination is (() -> EmptyView)) {
                NavigationLink(isActive: $isActiveNavigation, destination: destination) {EmptyView()}
            }
        }
        .padding(2)
        .contentShape(Rectangle())
        .simultaneousGesture(
            TapGesture()
                .onEnded {
                    if let action = action {
                        action()
                    }
                    if !(destination is (() -> EmptyView)) {
                        isActiveNavigation.toggle()
                    }
                }
        )

    }
}

struct SettingBlock_Previews: PreviewProvider {
    static var previews: some View {
        SettingBlock(image: "wifi", title: "Connection", displayContent:  {
            Text("HELLO")
        })
    }
}