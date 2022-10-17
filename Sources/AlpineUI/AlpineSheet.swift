////
////  SwiftUIView.swift
////  AlpineUI
////
////  Created by Jenya Lebid on 10/17/22.
////
//
//import SwiftUI
//
//
//struct AlpineSheet<Content: View>: View {
//    
//    @Binding var isPresented: Bool
//    var content: Content
//    
//    public init(isPresented: Binding<Bool>, @ViewBuilder content: () -> Content) {
//        self._isPresented = isPresented
//        self.content = content()
//    }
//    
//    var body: some View {
//        content
//            .background(Color("Background"))
//            .cornerRadius(10)
//            .shadow(radius: 3)
//    }
//}
//
//struct SheetBlock<Content: View>: ViewModifier {
//    
//    @Binding var isPresented: Bool
//    var sheetContent: Content
//
//    func body(content: Content) -> some View {
//        content
//            .overlay {
//                if isPresented {
//                    ZStack {
//                        Color(uiColor: .black)
//                            .opacity(0.4)
//                            .ignoresSafeArea()
//                        AlpineSheet(isPresented: $isPresented, content: sheetContent())
//                    }
//                }
//            }
//
//    }
//}
//
////struct SwiftUIView_Previews: PreviewProvider {
////    static var previews: some View {
////        SwiftUIView()
////    }
////}
