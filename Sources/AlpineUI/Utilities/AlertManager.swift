//
//  AlerManager.swift
//  PopupKit
//
//  Created by Jenya Lebid on 1/10/24.
//

import Foundation
import Observation

@Observable
public class AlertManager {
    
    public static var shared = AlertManager()
    
    var alertQueue = [SceneAlert]()
    
    var activeAlert: SceneAlert?
        
    public var isAlertPresented = false
    
    init() {}
}

extension AlertManager {
    
    func presentNextIfExists() {
        guard !isAlertPresented else { return }
        
        if let alert = alertQueue.first {
            activeAlert = alert
            alertQueue.removeFirst()
        }
        else {
            activeAlert = nil
        }
    }
}

public extension AlertManager {
    
    func presentAlert(_ alert: SceneAlert) {
        activeAlert = alert
    }
}
