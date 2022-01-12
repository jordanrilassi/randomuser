//
//  ReachabilityHelper.swift
//  RandomUsers
//
//  Created by Rilassi Jordan on 11/01/2022.
//

import Foundation

enum ReachabilityStatus {
    case wifi
    case cellular
    case notReachable
    case none
}

class ReachabilityManager {
    static let shared = ReachabilityManager()
    let reachability: Reachability?
    var reachabilityStatus: ReachabilityStatus = .none
    
    private init() {
        reachability = try? Reachability()
        reachability?.whenReachable = { [weak self] reachability in
            print("reachable")
            if reachability.connection == .wifi {
                self?.reachabilityStatus = .wifi
            } else {
                self?.reachabilityStatus = .cellular
            }
        }
        reachability?.whenUnreachable = { [weak self] _ in
            print("not reachable")
            self?.reachabilityStatus = .notReachable
        }

        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    
}
