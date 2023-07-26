//
//  SymbolPickerView.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 7/26/23.
//

import SwiftUI

struct SymbolPickerView: View {

    private static let symbols = Symbols.shared.allSymbols

    private static let gridDimension: CGFloat = 64
    private static let symbolSize: CGFloat = 24
    private static let symbolCornerRadius: CGFloat = 8
    private static let unselectedItemBackgroundColor = Color(UIColor.systemBackground)
    private static let selectedItemBackgroundColor = Color.accentColor
    private static let backgroundColor = Color(UIColor.systemGroupedBackground)


    @Binding public var symbol: String
    @State private var searchText = ""
    
    var title: String
    
    @Environment(\.presentationMode) private var presentationMode

    init(title: String, symbol: Binding<String>) {
        self.title = title
        _symbol = symbol
    }

    // MARK: - View Components

    private var searchableSymbolGrid: some View {
        symbolGrid
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic))
            .navigationTitle(title)
    }

    private var symbolGrid: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: Self.gridDimension, maximum: Self.gridDimension))]) {
                ForEach(Self.symbols.filter { searchText.isEmpty ? true : $0.localizedCaseInsensitiveContains(searchText) }, id: \.self) { thisSymbol in
                    Button {
                        symbol = thisSymbol
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        if thisSymbol == symbol {
                            Image(systemName: thisSymbol)
                                .font(.system(size: Self.symbolSize))
                                .frame(maxWidth: .infinity, minHeight: Self.gridDimension)
                                .background(Self.selectedItemBackgroundColor)
                                .cornerRadius(Self.symbolCornerRadius)
                                .foregroundColor(.white)
                        } else {
                            Image(systemName: thisSymbol)
                                .font(.system(size: Self.symbolSize))
                                .frame(maxWidth: .infinity, minHeight: Self.gridDimension)
                                .background(Self.unselectedItemBackgroundColor)
                                .cornerRadius(Self.symbolCornerRadius)
                                .foregroundColor(.primary)
                        }
                    }
                    .buttonStyle(.plain)
                    .hoverEffect(.lift)
                }
            }
            .padding(.horizontal)
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                Self.backgroundColor.edgesIgnoringSafeArea(.all)
                searchableSymbolGrid
            }
            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .cancellationAction) {
//                    Button(LocalizedString("cancel")) {
//                        presentationMode.wrappedValue.dismiss()
//                    }
//                }
//            }
        }
        .navigationViewStyle(.stack)
    }
}

private func LocalizedString(_ key: String) -> String {
    NSLocalizedString(key, bundle: .module, comment: "")
}

struct SymbolPicker_Previews: PreviewProvider {
    @State static var symbol: String = "square.and.arrow.up"

    static var previews: some View {
        Group {
            SymbolPickerView(title: "Test", symbol: Self.$symbol)
            SymbolPickerView(title: "Test", symbol: Self.$symbol)
                .preferredColorScheme(.dark)
        }
    }
}
