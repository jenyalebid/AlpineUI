//
//  AlertTextField.swift
//  PopupKit
//
//  Created by Jenya Lebid on 1/7/24.
//

import Foundation
import SwiftUI

public struct AlertTextField {
    
    var placehoder: String?
    var text: Binding<String>
    
    public init(placehoder: String?, text: Binding<String>) {
        self.placehoder = placehoder
        self.text = text
    }
}
