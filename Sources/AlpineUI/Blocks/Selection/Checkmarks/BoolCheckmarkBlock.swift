//
//  BoolCheckmarkBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 6/9/22.
//

import SwiftUI

public struct BoolCheckmarkBlock: View {
    
    @Binding var bool: NSNumber
    @Binding var changed: Bool
    
    private var title: String
    private var ch1Title: String
    private var ch2Title: String
    private var required: Bool
    private var spacing: Double
    private var eventTracker: UIEventTracker?
    
    public init(title: String = "", ch1Title: String = "", ch2Title: String = "", bool: Binding<NSNumber>, spacing: Double = 20, required: Bool = false, changed: Binding<Bool>, eventTracker: UIEventTracker? = nil) {
        self.title = title
        self.ch1Title = ch1Title
        self.ch2Title = ch2Title
        self._bool = bool
        self.spacing = spacing
        self.required = required
        self._changed = changed
        self.eventTracker = eventTracker
    }
    
    public var body: some View {
        VStack(spacing: 2) {
            if title != "" {
                Text("\(title):").font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)

            }
            checkmarks
        }
    }
    
    var checkmarks: some View {
        HStack {
            CheckmarkBlock(text: ch1Title, checked: .constant(bool == true ? true : false), changed: .constant(false), independent: false, eventTracker: eventTracker)
                .onTapGesture {
                    bool = true
                }
            Divider()
                .padding(.horizontal, spacing)
                .frame(height: 30)
            CheckmarkBlock(text: ch2Title, checked: .constant(bool == false ? true : false), changed: .constant(false), independent: false, eventTracker: eventTracker)
                .onTapGesture {
                    bool = false
                }
        }
        .background(Color.clear)
        .padding(6)
        .overlay (
            Group {
                if required && (bool != 0 && bool != 1) {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(uiColor: .systemRed), lineWidth: 1.2)
                }
            }
        )
        .onChange(of: bool) { _ in
            changed.toggle()
        }
    }
}

//struct BoolCheckmarkBlock_Previews: PreviewProvider {
//    static var previews: some View {
//        BoolCheckmarkBlock(title1: "Yes", title2: "No", bool: .constant(true), changed: .constant(false))
//    }
//}
