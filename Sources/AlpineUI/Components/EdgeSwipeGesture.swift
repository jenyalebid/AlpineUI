//
//  EdgeSwipeGesture.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 2/9/24.
//

import SwiftUI

struct EdgeSwipeGestureModifier: UIViewRepresentable {
    
    var edge: UIRectEdge
    var onRecognized: () -> Void

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear

        let gesture = UIScreenEdgePanGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleSwipe))
        gesture.edges = edge
        view.addGestureRecognizer(gesture)

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(onRecognized: onRecognized)
    }

    class Coordinator: NSObject {
        var onRecognized: () -> Void

        init(onRecognized: @escaping () -> Void) {
            self.onRecognized = onRecognized
        }

        @objc func handleSwipe(gesture: UIScreenEdgePanGestureRecognizer) {
            if gesture.state == .recognized {
                onRecognized()
            }
        }
    }
}

public extension View {
    func onEdgeSwipe(edge: UIRectEdge, perform action: @escaping () -> Void) -> some View {
        self.overlay(EdgeSwipeGestureModifier(edge: edge, onRecognized: action))
    }
}
