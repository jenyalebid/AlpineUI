//
//  DateBlock.swift
//  
//
//  Created by Jenya Lebid on 1/18/23.
//

import SwiftUI

public struct DateBlock: View {
    
    @Binding var date: Date
    
    @State var showPicker = false

    private var title: String
    private var components: DatePicker<Label>.Components = .date
    private var actionOnDismiss: (() -> ())?
    
    public init(title: String, date: Binding<Date>, components: DatePickerComponents = .date, actionOnDismiss: (() -> ())? = nil) {
        self.title = title
        self._date = date
        self.components = components
        self.actionOnDismiss = actionOnDismiss
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            if title != "" {
                Text("\(title):")
                    .font(.footnote)
            }
            Text(date.toString(format: "MMM dd, yyyy"))
                .padding(8)
                .foregroundColor(Color(uiColor: .label))
                .background(Color(UIColor.systemBackground))
                .cornerRadius(5)
                .popover(isPresented: $showPicker) {
                    DatePicker("", selection: $date, displayedComponents: components)
                        .datePickerStyle(.graphical)
                        .frame(width: 320, height: 320)
                        .onDisappear {
                            if let actionOnDismiss {
                                actionOnDismiss()
                            }
                        }
                }
        }
        .onTapGesture {
            if !showPicker {
                showPicker = true
            }
        }
    }
}

struct DateBlock_Previews: PreviewProvider {
        
    static var previews: some View {
        DateBlock(title: "Date", date: .constant(Date()))
    }
}
