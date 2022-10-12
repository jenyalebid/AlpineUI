//
//  ListSortBlock.swift
//  Wildlife
//
//  Created by Jenya Lebid on 6/17/22.
//

import SwiftUI

public struct ListSortBlock: View {
    
    @StateObject var viewModel: ListSortViewModel
    
    @Binding var selection: SortOption
    @Binding var ascending: Bool
    
    public init(selection: Binding<SortOption>, options: [SortOption], ascending: Binding<Bool>) {
        self._selection = selection
        self._ascending = ascending
        _viewModel = StateObject(wrappedValue: ListSortViewModel(selection: selection.wrappedValue, options: options))
    }

    public var body: some View {
        HStack {
            Menu {
                ForEach(viewModel.options) { option in
                    Button(option.label) {
                        NotificationCenter.default.post(name: NSNotification.Name("ActivityListTopButtonClick"), object: nil, userInfo: ["animation": false])
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.50) {
                            viewModel.selection = option
                        }
                    }
                }
            } label: {
                HStack {
                    Text("sort by:")
                        .font(.caption2)
                    Text(viewModel.selection.label)
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 20)
                        .foregroundColor(Color(UIColor.label))
                }
                .padding(6.0)
                .overlay (
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(uiColor: .systemGray), lineWidth: 0.2)
                )
                .background(Color(UIColor.systemGray6).opacity(0.2))
                .cornerRadius(5)
            }
            .onChange(of: viewModel.selection) { new in
                selection = new
            }
            order
                .onChange(of: viewModel.order) { value in
                    ascending = (value == .ascending ? true : false)
                }
        }
        .padding()
    }
    
    var order: some View {
        VStack {
            OrderImage(order: .ascending, image: "chevron.up")
                .environmentObject(viewModel)
            OrderImage(order: .descending, image: "chevron.down")
                .environmentObject(viewModel)
        }
        .onTapGesture {
            NotificationCenter.default.post(name: NSNotification.Name("ActivityListTopButtonClick"), object: nil, userInfo: ["animation": false])
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.50) {
                viewModel.toggleOrder()
            }
        }
    }
        
    struct OrderImage: View {
        
        @EnvironmentObject var viewModel: ListSortViewModel
        
        var order: ListSortViewModel.Order
        var image: String
        
        var body: some View {
            Image(systemName: image)
                .foregroundColor(viewModel.order == order ? Color.accentColor : Color(uiColor: .systemGray))
                .font(.title2)
        }
    }
}

//struct ListFilterBlock_Previews: PreviewProvider {
//    
//    static var option = FilterOption(label: "Hex", predicate: NSPredicate())
//    
//    static var options = [FilterOption(label: "Hex", predicate: NSPredicate()), FilterOption(label: "Target Species", predicate: NSPredicate()), FilterOption(label: "Species Present", predicate: NSPredicate())]
//    
//    static var viewModel = ListFilterViewModel(selection: option, options: options)
//
//    static var previews: some View {
//        
//        ListFilterBlock(selection: .constant(option), options: options)
//            .environmentObject(viewModel)
//    }
//}

extension Binding where Value == Bool {
    func negate() -> Bool {
        return !(self.wrappedValue)
    }
}
