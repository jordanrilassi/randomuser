//
//  API.swift
//  RandomUsers
//
//  Created by Rilassi Jordan on 07/01/2022.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
}

protocol API {
    var method: HTTPMethod { get }
    var baseURLPath: String { get }
    var baseURL: URL { get }
    var path: String { get }
    var url: URL? { get }
    var request: URLRequest? { get }
    var timeout: TimeInterval { get }
}
