//
//  ListExpandableTextFieldBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 7/31/23.
//

import SwiftUI

public struct ListExpandableTextFieldBlock: View {
    
    var label: String
    @Binding var value: String
    
    var required: Bool
    
    public init(label: String, value: Binding<String>, required: Bool = false) {
        self.label = label
        self._value = value
        self.required = required
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            ListLabel(label)
            field
        }
    }
    
    var field: some View {
        ExpandableTextField(value: $value)
            .requiredOutline(required && value.isEmpty)
    }
}

public struct ExpandableTextField: View {

    @Binding var value: String
    
    var placeholder: String?
    var maxHeight: CGFloat

    @State private var textHeight = CGFloat.zero
    
    public init(value: Binding<String>, placeholder: String? = nil, maxHeight: CGFloat = 200) {
        self._value = value
        self.placeholder = placeholder
        self.maxHeight = maxHeight
    }

    public var body: some View {
        field
    }

    var field: some View {
        ZStack {
            UITextViewWrapper(text: $value, textHeight: $textHeight, maxHeight: maxHeight)
                .frame(height: min(textHeight, maxHeight))
            RoundedRectangle(cornerRadius: 5)
                .strokeBorder()
                .foregroundColor(Color(uiColor: .systemGray6))
            if placeholder != nil && value.isEmpty {
                Text(placeholder ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 5)
                    .foregroundColor(Color(uiColor: .systemGray3))
            }
        }
    }
}

fileprivate struct UITextViewWrapper: UIViewRepresentable {
    
    @Binding var text: String
    @Binding var textHeight: CGFloat
    
    let maxHeight: CGFloat

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.isScrollEnabled = true
        textView.text = text
        textView.font = .preferredFont(forTextStyle: .body)
        textView.keyboardDismissMode = .interactive
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 0)
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: context.coordinator, action: #selector(Coordinator.dismissKeyboard))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [flexSpace, doneButton]
        textView.inputAccessoryView = toolbar

        return textView
    }

    func updateUIView(_ textView: UITextView, context: Context) {
        textView.text = text
        DispatchQueue.main.async {
            self.textHeight = min(textView.contentSize.height, self.maxHeight)
        }
    }

    class Coordinator : NSObject, UITextViewDelegate {
        var parent: UITextViewWrapper

        init(_ textView: UITextViewWrapper) {
            self.parent = textView
        }

        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
            self.parent.textHeight = min(textView.contentSize.height, self.parent.maxHeight)
        }
        
        @objc func dismissKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

struct ListExpandableTextFieldBlock_Previews: PreviewProvider {
    
    @State static var value: String = ""
    
    static var previews: some View {
        List {
            ListExpandableTextFieldBlock(label: "Test", value: $value)
        }
    }
}
