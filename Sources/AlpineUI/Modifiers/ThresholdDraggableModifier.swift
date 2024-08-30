//
//  ThresholdDraggableModifier.swift
//
//
//  Created by Vladislav on 8/30/24.
//

import SwiftUI

struct ThresholdDraggableModifier: ViewModifier {
        
    @Binding var alignment: Alignment
    
    @State private var position: CGPoint = .zero
    @State private var dragStartInitialPosition: CGPoint = .zero
        
    @State private var contentSize: CGSize = .zero
    @State private var anchorPoints = [CGPoint]() // Predefined positions to snap to
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .background(
                    GeometryReader { contentGeometry in
                        Rectangle()
                            .fill(.clear)
                            .onAppear {
                                contentSize = contentGeometry.size
                                position = position(from: alignment, parentSize: geometry.size, childSize: contentSize)
                            }
                            .onChange(of: contentGeometry.size) { oldValue, newValue in
                                contentSize = contentGeometry.size
                                position = position(from: alignment, parentSize: geometry.size, childSize: contentSize)
                            }
                    }
                )
                .position(position)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if dragStartInitialPosition == .zero {
                                self.dragStartInitialPosition = self.position
                            }
                            
                            let newPosition = CGPoint(x: dragStartInitialPosition.x + value.translation.width, y: dragStartInitialPosition.y + value.translation.height)
                            self.position = newPosition
                        }
                        .onEnded { value in
                            let alignment = calculateAlignment(from: value.location, in: geometry.size)
                            position = position(from: alignment, parentSize: geometry.size, childSize: contentSize)
                            dragStartInitialPosition = position
                            
                            self.alignment = calculateAlignment(from: position, in: geometry.size)
                        }
                )
                .animation(.interactiveSpring(response: 0.55, dampingFraction: 0.65, blendDuration: 0.95), value: position)
                .onAppear {
                    anchorPoints = computeAnchorPoints(in: geometry.size)
                }
                .onChange(of: geometry.size) { oldValue, newValue in
                    anchorPoints = computeAnchorPoints(in: newValue)
                }
        }

    }
}

extension ThresholdDraggableModifier {
    
    func computeAnchorPoints(in size: CGSize) -> [CGPoint] {
        [
            CGPoint(x: size.width / 2, y: size.height / 2), // Center
            CGPoint(x: 0, y: 0), // Top Leading
            CGPoint(x: size.width, y: 0), // Top Trailing
            CGPoint(x: 0, y: size.height), // Bottom Leading
            CGPoint(x: size.width, y: size.height), // Bottom Trailing
            CGPoint(x: size.width / 2, y: 0), // Top
            CGPoint(x: size.width / 2, y: size.height), // Bottom
            CGPoint(x: 0, y: size.height / 2), // Leading
            CGPoint(x: size.width, y: size.height / 2) // Trailing
        ]
    }
    
    func position(from alignment: Alignment, parentSize: CGSize, childSize: CGSize) -> CGPoint {
        let x: CGFloat
        let y: CGFloat
        
        switch alignment {
        case .topLeading:
            x = childSize.width / 2
            y = childSize.height / 2
        case .top:
            x = parentSize.width / 2
            y = childSize.height / 2
        case .topTrailing:
            x = parentSize.width - childSize.width / 2
            y = childSize.height / 2
        case .leading:
            x = childSize.width / 2
            y = parentSize.height / 2
        case .center:
            x = parentSize.width / 2
            y = parentSize.height / 2
        case .trailing:
            x = parentSize.width - childSize.width / 2
            y = parentSize.height / 2
        case .bottomLeading:
            x = childSize.width / 2
            y = parentSize.height - childSize.height / 2
        case .bottom:
            x = parentSize.width / 2
            y = parentSize.height - childSize.height / 2
        case .bottomTrailing:
            x = parentSize.width - childSize.width / 2
            y = parentSize.height - childSize.height / 2
        default:
            // Fallback to center if the alignment is not recognized
            x = parentSize.width / 2
            y = parentSize.height / 2
        }
        
        return CGPoint(x: x, y: y)
    }

    
    func calculateAlignment(from position: CGPoint, in size: CGSize) -> Alignment {
        let thirdsWidth = size.width / 3
        let thirdsHeight = size.height / 3
        
        switch position {
        case let p where p.x < thirdsWidth && p.y < thirdsHeight:
            return .topLeading
        case let p where p.x >= thirdsWidth && p.x < 2 * thirdsWidth && p.y < thirdsHeight:
            return .top
        case let p where p.x >= 2 * thirdsWidth && p.y < thirdsHeight:
            return .topTrailing
        case let p where p.x < thirdsWidth && p.y >= thirdsHeight && p.y < 2 * thirdsHeight:
            return .leading
        case let p where p.x >= thirdsWidth && p.x < 2 * thirdsWidth && p.y >= thirdsHeight && p.y < 2 * thirdsHeight:
            return .center
        case let p where p.x >= 2 * thirdsWidth && p.y >= thirdsHeight && p.y < 2 * thirdsHeight:
            return .trailing
        case let p where p.x < thirdsWidth && p.y >= 2 * thirdsHeight:
            return .bottomLeading
        case let p where p.x >= thirdsWidth && p.x < 2 * thirdsWidth && p.y >= 2 * thirdsHeight:
            return .bottom
        case let p where p.x >= 2 * thirdsWidth && p.y >= 2 * thirdsHeight:
            return .bottomTrailing
        default:
            return .center
        }
    }
}

