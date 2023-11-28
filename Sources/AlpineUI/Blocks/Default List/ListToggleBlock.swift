//
//  ListToggleBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/4/23.
//

import SwiftUI

public struct ListToggleBlock: View {
    
    var title: String
    private var showTitle: Bool
    
    @Binding var isOn: Bool
    
    public init(title: String, isOn: Binding<Bool>) {
        self.title = title
        self._isOn = isOn
        
        self.showTitle = true
    }
    
    public init(isOn: Binding<Bool>) {
        self.title = ""
        self._isOn = isOn
        
        self.showTitle = false
    }
    
    public var body: some View {
        if showTitle {
            titleToggle
        }
        else {
            toggle
        }
    }
    
    var titleToggle: some View {
        HStack {
            ListLabel(title)
            Spacer()
            toggle
        }
    }
    var toggle: some View {
        Toggle(title, isOn: $isOn)
            .labelsHidden()
    }
}

public struct ListIconToggleBlock: View {
    
    var systemImage: String
    var title: String?
    
    @Binding var isOn: Bool
    
    public init(_ systemImage: String, title: String? = nil, isOn: Binding<Bool>) {
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
        }
    }
}

struct ListToggleBlock_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ListToggleBlock(title: "Visible", isOn: .constant(true))
        }
    }
}
