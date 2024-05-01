//
//  Date.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 9/19/22.
//

import Foundation

public extension Date {
    
    public func toString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func passedTime(from date: Date, to endDate: Date = Date()) -> String {
        let difference = Calendar.current.dateComponents([.minute, .second], from: date, to: endDate)
        
        let strMin = String(format: "%02d", difference.minute ?? 00)
        let strSec = String(format: "%02d", difference.second ?? 00)
        
        return "\(strMin):\(strSec)"
    }
    
    
    func hoursAndMinutes(to date: Date) -> (hours: Int, minutes: Int) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: self, to: date)
        let hours = components.hour ?? 0
        let totalMinutes = components.minute ?? 0
        return (hours, totalMinutes)
    }
}
