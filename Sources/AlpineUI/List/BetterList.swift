//
//  BetterList.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 10/31/22.
//

import SwiftUI

public struct BetterList<Content: View>: View {
    
    var content: () -> Content
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                content()
            }
        }
        
    }
}

struct BetterList_Previews: PreviewProvider {
    static var previews: some View {
        BetterList {
            
        }
    }
}
