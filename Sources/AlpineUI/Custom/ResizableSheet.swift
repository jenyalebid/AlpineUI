//
//  ResizableSheet.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/11/22.
//

import UIKit
import SwiftUI

public class FormSheetWrapper<Content: View>: UIViewController, UIPopoverPresentationControllerDelegate {

    var content: () -> Content
    var onDismiss: (() -> Void)?

    private var hostVC: UIHostingController<Content>?

    required init?(coder: NSCoder) { fatalError("") }

    public init(content: @escaping () -> Content) {
        self.content = content
        super.init(nibName: nil, bundle: nil)
    }

    func show() {
        guard hostVC == nil else { return }
        let vc = UIHostingController(rootView: content())

        vc.view.sizeToFit()
        vc.preferredContentSize = vc.view.bounds.size

        vc.modalPresentationStyle = .formSheet
        vc.presentationController?.delegate = self
        hostVC = vc
        self.present(vc, animated: true, completion: nil)
    }

    func hide() {
        guard let vc = self.hostVC, !vc.isBeingDismissed else { return }
        dismiss(animated: true, completion: nil)
        hostVC = nil
    }

    public func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        hostVC = nil
        self.onDismiss?()
    }
}

struct ResizeableSheet<Content: View> : UIViewControllerRepresentable {

    @Binding var show: Bool

    let content: () -> Content

    func makeUIViewController(context: UIViewControllerRepresentableContext<ResizeableSheet<Content>>) -> FormSheetWrapper<Content> {
        let vc = FormSheetWrapper(content: content)
        vc.onDismiss = { self.show = false }
        return vc
    }

    func updateUIViewController(_ uiViewController: FormSheetWrapper<Content>, context: UIViewControllerRepresentableContext<ResizeableSheet<Content>>) {
        if show {
            uiViewController.show()
        }
        else {
            uiViewController.hide()
        }
    }
}

