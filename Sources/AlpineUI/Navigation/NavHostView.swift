//
//  NavHostView.swift
//  AlpineConnect
//
//  Created by Jenya Lebid on 3/7/23.
//

import SwiftUI

//struct NavHost<Content: Viewable>: View {
//
//    var content: Content
//
//    public var body: some View {
//        content.body
//    }
//}
//
//
//public struct nn: View {
//
//    var object: (any Viewable)?
//
//    public var body: some View {
////        object!.body
//        EmptyView()
//    }
//}
//
//public struct SampleView<T: Viewable>: View {
//
//    var object: T?
//
//    public var body: some View {
//        object!.body
//    }
//}


public protocol NavHost: View {

    var object: Viewable? { get }
    
//    @ViewBuilder
//    func views(for object: Viewable) -> V
}

//public extension NavHost {
//
//    @ViewBuilder
//    func views(for object: Viewable) -> some View {
//        EmptyHostView()
//    }
//}

//public struct NavHostView: NavHost {
//
//    @State public var object: (any Viewable)?
//
//    public init(object: (any Viewable)?) {
//        self._object = State(initialValue: object)
//    }
//
//    public var body: some View {
//        if let object {
//            EmptyView()
//        }
//        else {
//            empty
//        }
//    }
//
//    var empty: some View {
//        Text("Error: Stack object is empty.")
//    }
//}

struct EmptyHostView: View {

    var body: some View {
        Text("This is an empty view. NavHostView must be extended on application level")
    }
}
