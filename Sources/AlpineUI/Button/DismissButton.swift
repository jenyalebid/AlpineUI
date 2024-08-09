//
//  DismissButton.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 10/24/23.
//

import SwiftUI

@available(iOS 17, *)
public struct DismissButton: View {
    
    @Environment(\.dismiss) var dismiss

    private var environmentDismiss: Bool
    private var action: (() -> Void)?
    private var onEvent: ((UIEvent, [String: Any]?) -> Void)?
    
    public init(environmentDismiss: Bool = true,
                action: (() -> Void)? = nil,
                onEvent: ((UIEvent, [String: Any]?) -> Void)? = nil) {
        self.environmentDismiss = environmentDismiss
        self.action = action
        self.onEvent = onEvent
    }
    
    public var body: some View {
        Button(role: .cancel) {
            if environmentDismiss {
                dismiss()
                onEvent?(.dismissButton, nil)
            }
            if let action {
                withAnimation {
                    action()
                }
            }
        } label: {
            Image(systemName: "xmark")
                .imageScale(.medium)
                .tint(.secondary)
                .padding(8)
                .background(Color(uiColor: .systemGray5))
                .clipShape(Circle())
        }
    }
}

#Preview {
    if #available(iOS 17, *) {
        NavigationStack {
            List {
                Text("...")
            }
            .toolbar {
                DismissButton()
            }
        }
    } else {
        EmptyView()
    }
}
