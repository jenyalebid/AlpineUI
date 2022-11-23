//
//  String.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 11/23/22.
//

import Foundation

extension String {
    
    static public func coordinateToDisplayText(longitude: Double, latitude: Double) -> String {
        if latitude == 0 && longitude == 0 {
            return ""
        }
        let NS = latitude  >= 0 ? Character("N") : Character("S")
        let EW = longitude >= 0 ? Character("E") : Character("W")
        let lat = abs(latitude)
        let lon = abs(longitude)
        
        return String(format:"% 9.5f°\(NS)%  10.5f°\(EW)", lat, lon)
    }
}
