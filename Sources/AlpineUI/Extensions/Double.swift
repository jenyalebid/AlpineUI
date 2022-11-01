//
//  Double.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 11/1/22.
//

import Foundation

extension Double {
    
    public func secondsToTime(style: DateComponentsFormatter.UnitsStyle = .full) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = style
        
        return formatter.string(from: TimeInterval(self))!
    }
    
    public func secondsToTime() -> String {
        let (hr,  minf) = modf(self / 3600)
        let (min, secf) = modf(60 * minf)
        
        let h = String(format: "%02d", Int(hr))
        let m = String(format: "%02d", Int(min))
        let s = String(format: "%02d", Int(60 * secf))
        
        return "\(h):\(m):\(s)"

    }
}
