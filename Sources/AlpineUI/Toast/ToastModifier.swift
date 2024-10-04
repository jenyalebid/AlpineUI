//
//  ToastModifier.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 10/4/24.
//

import SwiftUI

private struct ToastMakerEnvironmentKey: EnvironmentKey {
    static let defaultValue: ToastMaker = ToastMaker()
}

public extension EnvironmentValues {
    var toastMaker: ToastMaker {
        get { self[ToastMakerEnvironmentKey.self] }
        set { self[ToastMakerEnvironmentKey.self] = newValue }
    }
}

@Observable
public class ToastMaker {
    
    public struct Toast: Equatable {
        var text: String
        var systemImage: String
        var imageColor: Color
    }
    
    internal var currentToast: Toast?
    internal init() {}
    
    public func makeToast(text: String, systemImage: String, imageColor: Color = .accentColor) {
        withAnimation {
            currentToast = Toast(text: text, systemImage: systemImage, imageColor: imageColor)
        }
    }
}

struct ToastModifier: ViewModifier {
    
    @State private var toaskMaker = ToastMaker()
    @State private var timer: Timer?
    
    func body(content: Content) -> some View {
        content
            .environment(\.toastMaker, toaskMaker)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(alignment: .top) {
                if let toast = toaskMaker.currentToast {
                    HStack {
                        Image(systemName: toast.systemImage)
                            .foregroundStyle(toast.imageColor)
                        Text(toast.text)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .font(.callout)
                    .fontWeight(.semibold)
                    .background(.regularMaterial)
                    .clipShape(Capsule())
                    .clipped()
                    .shadow(radius: 5)
                    .padding(.top)
                }
            }
            .onChange(of: toaskMaker.currentToast) { oldValue, newValue in
                if newValue != nil {
                    startTimer()
                }
            }
    }
    
    private func startTimer() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
            withAnimation {
                toaskMaker.currentToast = nil
            }
        }
    }
}

public extension View {
    func toastMaker() -> some View {
        modifier(ToastModifier())
    }
}

#Preview {
    VStack {
        
    }
}
