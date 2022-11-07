//
//  SlideGestureViewModel.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 11/7/22.
//

import SwiftUI

class SlideGestureViewModel: ObservableObject {
    
    @Published var xOffset = CGFloat(0)
    @Published var yOffset = CGFloat(0)
    
    var allowMovement: Bool
    
    var alignmnet: Alignment
    
    var slideEdge: Edge {
        switch alignmnet {
        case .trailing:
            return .trailing
        case .leading:
            return .leading
        case .topLeading:
            return .leading
        case .top:
            return .top
        case .bottom:
            return .bottom
        default:
            return .trailing
        }
    }
    
    var shadow: CGFloat {
        switch slideEdge {
        case .leading:
            return 2
        default:
            return -2
        }
    }
    
    init(alignmnet: Alignment, allowMovement: Bool) {
        self.alignmnet = alignmnet
        self.allowMovement = allowMovement
    }
    
    func greaterOrLessThan(first: CGPoint, second: CGPoint) -> Bool {
        switch slideEdge {
        case .bottom:
            if first.y > second.y {
                return true
            }
            return false
        case .leading:
            if first.x < second.x {
                return true
            }
            return false
        default:
            if first.x > second.x {
                return true
            }
            return false
        }
    }
    
    func movementChange(value: DragGesture.Value) {
        switch slideEdge {
        case .leading:
            if value.translation.width < 20 {
                xOffset = value.translation.width
            }
        case .bottom:
            if value.translation.height > 20 {
                yOffset = value.translation.height
            }
        default:
            if value.translation.width > -20 {
                xOffset = value.translation.width
            }
        }
    }
}
