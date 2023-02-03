//
//  SwiftUIView.swift
//  
//
//  Created by Jenya Lebid on 2/2/23.
//

import SwiftUI

struct SwiftUIView: View {
    
    
    var body: some View {
        HStack {
            ProgressView()
                .progressViewStyle(.circular)
                .scaleEffect(2)
                .padding()
            Text("Map Loading..")
                .font(.headline)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
