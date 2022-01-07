//
//  HomeWorker.swift
//  RandomUsers
//
//  Created by Rilassi Jordan.

import UIKit
import Combine

class HomeWorker
{
    private let userService: UserAPIServiceProtocol
    
    init(userService: UserAPIServiceProtocol) {
        self.userService = userService
    }
    
    func loadUserBatch(_ getUserRequest: GetUsersRequest, completion: @escaping APIServiceCompletion<GetUsersResponse>) -> Cancellable? {
        userService.getUsers(getUserRequest, completion: completion)
    }
}
