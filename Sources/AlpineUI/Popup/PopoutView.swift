//
//  PopoutView.swift
//  PopupKit
//
//  Created by Jenya Lebid on 2/8/24.
//

import SwiftUI

struct PopoutView: View {
        
    @State private var timer: Timer?
    @State private var animate = false
        
    @State private var popout: PKPopoutManager.Popout?
    
    var body: some View {
        Group {
            if let popout {
                show(popout)
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("PK_Popout"))) { info in
            if let popout = info.object as? PKPopoutManager.Popout {
                withAnimation {
                    self.popout = popout
                    startTimer()
                }
            }
        }
    }
    
    func show(_ popout: PKPopoutManager.Popout) -> some View {
        VStack {
            Image(systemName: popout.systemImage)
                .imageScale(.large)
                .padding(10)
                .symbolEffect(.bounce, value: animate)
            Text(popout.message)
        }
        .font(.title3)
        .padding()
        .background()
        .backgroundStyle(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .transition(.opacity)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                animate.toggle()
            }
        }
    }
    
    private func startTimer() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
            withAnimation {
                popout = nil
            }
        }
    }
}

