//
//  ListToggleBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/4/23.
//

import SwiftUI

public struct ListToggleBlock: View {
    
    var title: String
    @Binding var isOn: Bool
    
    public init(title: String, isOn: Binding<Bool>) {
        self.title = title
        self._isOn = isOn
    }
    
    public var body: some View {
        HStack {
            ListLabel(title)
            Spacer()
            Toggle(title, isOn: $isOn)
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
