//
//  ListIconToggleBlock.swift
//
//
//  Created by Vladislav on 8/7/24.
//

import SwiftUI

public struct ListIconToggleBlock: View {
    
    @Binding var isOn: Bool
    
    private var systemImage: String
    private var title: String?
    private var onEvent: ((AlpineUIEvent, [String: Any]?) -> Void)?
    
    public init(_ systemImage: String, title: String? = nil, isOn: Binding<Bool>, onEvent: ((AlpineUIEvent, [String: Any]?) -> Void)? = nil ) {
        self.systemImage = systemImage
        self.title = title
        self._isOn = isOn
    }
    
    public var body: some View {
        HStack {
            Image(systemName: systemImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20, alignment: .center)
                .padding(.trailing, 4)
            if let title {
                Text(title)
            }
            Spacer()
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .onChange(of: isOn) { oldValue, newValue in
                    onEvent?(.toggleAction, ["title": title, "isOn": newValue])
                }
        }
    }
}
