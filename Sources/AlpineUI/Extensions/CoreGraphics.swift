//
//  CoreGraphics.swift
//  AlpineMapKit
//
//  Created by mkv on 4/6/22.
//

import Foundation
import CoreGraphics


public extension CGSize {
    
    static func +(lhs: Self, rhs: Self) -> CGSize {
        CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
    
    static func +=(lhs: inout CGSize, rhs: CGSize) {
        lhs = lhs + rhs
    }
    
    static func -(lhs: Self, rhs: CGFloat) -> CGSize {
        CGSize(width: lhs.width - rhs, height: lhs.height - rhs)
    }
    
    static func *(lhs: Self, mult: CGFloat) -> CGSize {
        CGSize(width: lhs.width * mult, height: lhs.height * mult)
    }
    
    static func /(lhs: Self, div: CGFloat) -> CGSize {
        CGSize(width: lhs.width / div, height: lhs.height / div)
    }
}


public extension CGPoint {
    
    static func *(lhs: Self, mult: CGFloat) -> CGPoint {
        CGPoint(x: lhs.x * mult, y: lhs.y * mult)
    }
    
    static func /(lhs: Self, div: CGFloat) -> CGPoint {
        CGPoint(x: lhs.x / div, y: lhs.y / div)
    }
    
    static func +(lhs: Self, rhs: CGFloat) -> CGPoint {
        CGPoint(x: lhs.x + rhs, y: lhs.y + rhs)
    }
    
    static func -(lhs: Self, rhs: CGFloat) -> CGPoint {
        CGPoint(x: lhs.x - rhs, y: lhs.y - rhs)
    }
    
    func distance(to: CGPoint) -> CGFloat {
        return sqrt(pow((to.x - self.x), 2) + pow((to.y - self.y), 2))
    }
}
