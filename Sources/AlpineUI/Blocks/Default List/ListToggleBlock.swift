//
//  ListToggleBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/4/23.
//

import SwiftUI

public struct ListToggleBlock: View {
    
    @Binding var isOn: Bool
    
    private var title: String
    private var showTitle: Bool
    private var onEvent: ((AlpineUIEvent, [String: Any]?) -> Void)?
    
    public init(title: String, isOn: Binding<Bool>, onEvent: ((AlpineUIEvent, [String: Any]?) -> Void)? = nil) {
        self.title = title
        self._isOn = isOn
        
        self.showTitle = true
    }
    
    public init(isOn: Binding<Bool>, onEvent: ((AlpineUIEvent, [String: Any]?) -> Void)? = nil) {
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
    
    private var titleToggle: some View {
        HStack {
            ListLabel(title)
            Spacer()
            toggle
        }
    }
    private var toggle: some View {
        Toggle(title, isOn: $isOn)
            .labelsHidden()
            .onChange(of: isOn) { oldValue, newValue in
                onEvent?(.toggleAction, ["title": title, "isOn": newValue])
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
