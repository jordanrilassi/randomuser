//
//  UserAPIService.swift
//  RandomUsers
//
//  Created by Rilassi Jordan on 07/01/2022.
//

import Foundation
import Combine

protocol UserAPIServiceProtocol {
    func getUsers(_ getUsersRequest: GetUsersRequest, completion: @escaping APIServiceCompletion<GetUsersResponse>) -> Cancellable?
}

struct UserAPIService: APIService, UserAPIServiceProtocol {
    func getUsers(_ getUsersRequest: GetUsersRequest, completion: @escaping APIServiceCompletion<GetUsersResponse>) -> Cancellable? {
        guard let request = UserAPI.getUsers(getUsersRequest: getUsersRequest).request else { return nil }
        
        return performRequest(request: request) { (result: APIServiceResult<GetUsersResponse>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
