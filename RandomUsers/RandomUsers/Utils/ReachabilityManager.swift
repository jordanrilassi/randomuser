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
    var reachabilityCompletion: (() -> Void)? = nil
    
    private init() {
        reachability = try? Reachability()
        reachability?.whenReachable = { [weak self] reachability in
            print("reachable")
            if reachability.connection == .wifi {
                self?.reachabilityStatus = .wifi
            } else {
                self?.reachabilityStatus = .cellular
            }
            self?.reachabilityCompletionAction()
        }
        reachability?.whenUnreachable = { [weak self] _ in
            print("not reachable")
            self?.reachabilityStatus = .notReachable
            self?.reachabilityCompletionAction()
        }

        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
            reachabilityCompletionAction()
        }
    }
    
    private func reachabilityCompletionAction() {
        guard let reachabilityCompletion = reachabilityCompletion else { return }
        reachabilityCompletion()
    }
}
