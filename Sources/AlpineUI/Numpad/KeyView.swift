//
//  KeyView.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/25/22.
//

import SwiftUI

struct KeyView: View {
    
    @ObservedObject var viewModel: KeyViewModel
    
    @Binding var number: String
    
    init(value: String, number: Binding<String>, size: CGSize) {
        self._number = number
        viewModel = KeyViewModel(totalSize: size, value: value, number: number.wrappedValue)
    }
    
    var body: some View {
        Text(viewModel.value)
            .font(.title)
            .frame(width: viewModel.makeSize().width, height: viewModel.makeSize().height)
            .background(Color(uiColor: .systemGray6))
            .cornerRadius(5)
            .overlay(RoundedRectangle(cornerRadius: 5).stroke())
            .onTapGesture {
                number = viewModel.modifyNumber()
            }
    }
}

struct KeyView_Previews: PreviewProvider {
    static var previews: some View {
        KeyView(value: "1", number: Binding.constant("32"), size: UIScreen.main.bounds.size)
    }
}
