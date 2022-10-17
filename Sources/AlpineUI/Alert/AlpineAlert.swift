//
//  AlpineAlert.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 10/17/22.
//

import SwiftUI

public struct AlpineAlert: View {
    
    @Binding var isPresented: Bool
    
    var alert: AppAlert
    
    public init(isPresented: Binding<Bool>, alert: AppAlert) {
        self._isPresented = isPresented
        self.alert = alert
    }
    
    public var body: some View {
        VStack {
            Text(alert.title)
                .font(.title2)
            Divider()
                .frame(width: 120)
            Text(alert.message)
                .multilineTextAlignment(.center)
            Divider()
                .padding(.bottom, 6)
            if alert.actions.isEmpty {
                dismiss
            }
            if alert.actions.count == 1 {
                oneAction
            }
            else {
                VStack {
                    
                }
            }
        }
        .padding()
        .frame(width: 300)
        .background(Color("Background"))
        .cornerRadius(10)
        .shadow(radius: 3)
    }
    
    var dismiss: some View {
        TextButtonBlock(text: alert.dismiss.text, width: 100, height: 50, background: .accentColor) {
            withAnimation {
                isPresented.toggle()
                alert.dismiss.action()
            }
        }
    }
    
    
    var oneAction: some View {
        HStack {
            dismiss
            Divider()
                .frame(height: 20)
                .padding()
            TextButtonBlock(text: alert.actions[0].text, width: 100, height: 50, background: color(alert.actions[0].role)) {
                withAnimation {
                    isPresented.toggle()
                    alert.actions[0].action()
                }
            }
        }
    }
    
    func color(_ type: AlertAction.AlertButtonRole) -> Color {
        switch type {
        case .destructive:
            return .red
        case .regular:
            return .accentColor
        case .dismiss:
            return .accentColor
        }
    }
}

struct AlpineAlertViewModifier: ViewModifier {
    
    @Binding var isPresented: Bool
    var alert: AppAlert
    
    func body(content: Content) -> some View {
        content
            .disabled(isPresented)
            .overlay {
                if isPresented {
                    AlpineAlert(isPresented: $isPresented, alert: alert)
                        .transition(.scale)
                }
            }
    }
}

extension View {
    public func appAlert(isPresented: Binding<Bool>, alert: AppAlert) -> some View {
        return modifier(AlpineAlertViewModifier(isPresented: isPresented, alert: alert))
    }
}

struct AlertTest: View {
    
    @State var showAlert = true
    
    var alert = AppAlert(title: "Hello", message: "This is a better alert becuase the defualt ones are not very good.", dismiss: AlertAction(text: "Okay"), actions: [AlertAction(text: "Do It", role: .regular, action: {})])
    
    var body: some View {
        
        Button("Show Alert") {
            withAnimation {
                showAlert.toggle()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .appAlert(isPresented: $showAlert, alert: alert)
    }
    
}

struct AlpineAlert_Previews: PreviewProvider {
    static var previews: some View {
        AlertTest()
    }
}

