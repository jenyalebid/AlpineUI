//
//  UIEventLogger.swift
//
//
//  Created by Vladislav on 8/6/24.
//

import Foundation

/// A protocol for tracking UI events and logging them to an analytics service.
///
/// The `UIEventTracker` protocol provides methods for logging basic and detailed UI events. Implement this protocol
/// in a class or struct to handle the logging of events to your analytics service.
///
/// Example usage:
/// ```swift
/// class MyEventTracker: UIEventTracker {
///     func logEvent(_ event: String, parameters: [String: Any]?) {
///         // Implementation for logging event
///     }
/// }
///
/// let tracker = MyEventTracker()
/// tracker.logUIEvent(.dismissButton, typ: .presses, parameters: ["title": "Close"])
/// ```
///
public protocol UIEventTracker: AnyObject {
    
    /// Logs a basic UI event.
    ///
    /// This method logs a UI event with the given name and optional parameters.
    ///
    /// - Parameters:
    ///   - event: The name of the event to log.
    ///   - parameters: An optional dictionary of parameters associated with the event. Defaults to `nil`.
    func logEvent(_ event: String, parameters: [String: Any]?)
    
    /// Logs an event of type `UIEvent` to Firebase Analytics.
    ///
    /// This method uses `logUIEvent` to send the event to Firebase Analytics. The event is specified
    /// using the `UIEvent` enumeration and can be accompanied by optional parameters.
    ///
    /// - Parameters:
    ///   - event: The event to be logged, from the `UIEvent` enumeration.
    ///   - typ: An optional type of the event, from the `UIEventType` enumeration. Defaults to `nil`.
    ///   - fileInfo: An optional string containing file information. Defaults to `nil`.
    ///   - parameters: An optional dictionary of parameters associated with the event. Defaults to `nil`.
    ///   - file: The name of the file from which the function is called. Defaults to the file where the function is called.
    ///   - function: The name of the function from which the function is called. Defaults to the function where the function is called.
    ///   - line: The line number from which the function is called. Defaults to the line where the function is called.
    ///
    /// - Note:
    ///   Ensure that the `UIEvent` enumeration includes all possible events you want to log.
    func logUIEvent(_ event: UIEvent, typ: UIEventType?, fileInfo: String?, parameters: [String: Any]?, file: String, function: String, line: Int)
}

public extension UIEventTracker {
    
    /// Default implementation for logging a detailed UI event with additional information.
    ///
    /// This method logs a detailed UI event with additional information such as the type of event,
    /// the source file, function, and line number where the event occurred.
    func logUIEvent(_ event: UIEvent, typ: UIEventType? = .presses,
                    fileInfo: String? = nil,
                    parameters: [String: Any]? = nil,
                    file: String = #file,
                    function: String = #function,
                    line: Int = #line) {
        
        var updatedParameters = parameters ?? [:]
        updatedParameters["appTarget"] = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? "Unknown Target"
        updatedParameters["fileInfo"] = "File: \(URL(fileURLWithPath: file).lastPathComponent), Function: \(function), Line: \(line)"
        updatedParameters["eventTyp"] = typ?.rawValue
        logEvent(event.rawValue, parameters: updatedParameters)
    }
}
