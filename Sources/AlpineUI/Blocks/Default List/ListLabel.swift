//
//  ListLabel.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/4/23.
//

import SwiftUI

public struct ListLabel: View {
    
    var label: AttributedString?
    
    public init(_ label: CustomStringConvertible?) {
        if let attributedString = label as? AttributedString {
            self.label = attributedString
        } else if let string = label as? String {
            self.label = AttributedString(string)
        } else {
            self.label = nil
        }
    }
    
    public var body: some View {
        if let label {
            Text(label + ":")
                .font(.caption)
        }
    }
}

struct ListLabelBlock_Previews: PreviewProvider {
    static var previews: some View {
        ListLabel("Title")
    }
}
