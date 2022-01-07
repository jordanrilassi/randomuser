//
//  UserAPI.swift
//  RandomUsers
//
//  Created by Rilassi Jordan on 07/01/2022.
//

import Foundation

enum UserAPI: API {
    case getUsers(getUsersRequest: GetUsersRequest)
    
    var method: HTTPMethod {
        .GET
    }
    
    var baseURLPath: String {
        Environment.hostBaseURLPath
    }
    
    var baseURL: URL {
        URL(string: Environment.hostBaseURLPath)!
    }
    
    var path: String {
        switch self {
        case .getUsers(let request):
            return "?page=\(request.page)&results=\(request.count)"
        }
    }
    
    var url: URL? {
        URL(string: path, relativeTo: baseURL)
    }
    
    var request: URLRequest? {
        guard let url = url else { return nil }

        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        request.timeoutInterval = timeout

        return request
    }
    
    var timeout: TimeInterval {
        10
    }
    
    
}
