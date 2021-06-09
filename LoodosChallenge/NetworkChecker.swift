//
//  NetworkChecker.swift
//  LoodosChallenge
//
//  Created by Sociable on 3.06.2021.
//

import Foundation
import Network


class NetworkChecker {
    static let shared = NetworkChecker()
    let dispatchQueue = DispatchQueue(label: "networkChecker")
    var pathMonitor = NWPathMonitor()
    var path: NWPath?
    var isConnected = false
    
    func trackInternetConnection() {
        guard pathMonitor.pathUpdateHandler == nil else { return }
        pathMonitor.pathUpdateHandler = { update in
            if update.status == .satisfied {
                self.isConnected = true
            } else {
                self.isConnected = false
            }
        }
        pathMonitor.start(queue: dispatchQueue)
    }
    
}
