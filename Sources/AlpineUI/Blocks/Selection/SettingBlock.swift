//
//  SettingBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 9/27/22.
//

import SwiftUI

public struct SettingBlock<Content: View, Destination: View>: View {
    
    private var image: String
    private var color: Color = .accentColor
    private var title: String
    private var subtitle: String?
    private var displayContent: () -> Content
    private var destination: () -> Destination
    private var action: (() -> ())?
    private var onEvent: ((AlpineUIEvent, [String: Any]?) -> Void)?
    
    @State var isActiveNavigation = false
    
    public init(image: String, color: Color = .accentColor, title: String, subtitle: String? = nil, onEvent: ((AlpineUIEvent, [String: Any]?) -> Void)? = nil, @ViewBuilder displayContent: @escaping () -> Content = {EmptyView()}, destination: @escaping (() -> Destination) = {EmptyView()}, action: (() -> ())? = nil) {
        self.image = image
        self.color = color
        self.title = title
        self.subtitle = subtitle
        self.displayContent = displayContent
        self.destination = destination
        self.action = action
        self.onEvent = onEvent
    }
    
    public var body: some View {
        if action != nil || !(destination is (() -> EmptyView)) {
            blockContent
                .background(
                    Group {
                        if !(destination is (() -> EmptyView)) {
                            NavigationLink(isActive: $isActiveNavigation, destination: destination) {EmptyView()}
                        }
                    }
                )
                .simultaneousGesture(
                    TapGesture()
                        .onEnded {
                            onEvent?(.tapAction, ["place": "setting", "action": "tap", "title": title])
                            if let action = action {
                                action()
                            }
                            if !(destination is (() -> EmptyView)) {
                                isActiveNavigation.toggle()
                                onEvent?(.navigationLinkActivated, ["destination": String(describing: Destination.self)])
                            }
                        }
                )
        } else {
            blockContent
        }
    }
    
    var blockContent: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke()
                    .frame(width: 34, height: 34, alignment: .leading)
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 16.0)
            }
            .padding(.trailing, 6)
            .foregroundColor(color)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.medium)
                if let subtitle {
                    Text(subtitle)
                        .font(.caption2)
                        .foregroundColor(Color(uiColor: .systemGray))
                        .lineLimit(4)
                }
            }
            Spacer()
            displayContent()
        }
        .padding([.vertical, .leading], 2)
        .contentShape(Rectangle())
    }
}

struct SettingBlock_Previews: PreviewProvider {
    static var previews: some View {
        SettingBlock(image: "wifi", title: "Connection", displayContent:  {
            Text("HELLO")
        })
    }
}
