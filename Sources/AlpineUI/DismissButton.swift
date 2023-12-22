//
//  DismissButton.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 10/24/23.
//

import SwiftUI

@available(iOS 17, *)
public struct DismissButton: View {

    var environmentDismiss: Bool
    var action: (() -> Void)?
    
    @Environment(\.dismiss) var dismiss
    
    public init(environmentDismiss: Bool = true, action: (() -> Void)? = nil) {
        self.environmentDismiss = environmentDismiss
        self.action = action
    }
    
    public var body: some View {
        Button(role: .cancel) {
            if environmentDismiss {
                dismiss()
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
