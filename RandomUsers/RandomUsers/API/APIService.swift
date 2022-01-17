//
//  APIService.swift
//  RandomUsers
//
//  Created by Rilassi Jordan on 06/01/2022.
//

import Foundation
import Combine

typealias APIServiceCompletion<T> = (APIServiceResult<T>) -> Void
typealias APIServiceResult<T> = Result<T, Error>

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
}

protocol API {
    var method: HTTPMethod { get }
    var baseURL: URL { get }
    var path: String { get }
    var url: URL? { get }
    var request: URLRequest? { get }
    var timeout: TimeInterval { get }
}

protocol APIService {
    func performRequest<T: Codable>(request: URLRequest, callback: @escaping APIServiceCompletion<T>) -> Cancellable?
}

extension APIService {
    
    func performRequest<T: Codable>(request: URLRequest, callback: @escaping APIServiceCompletion<T>) -> Cancellable? {
        if ReachabilityManager.shared.reachabilityStatus == .notReachable || ReachabilityManager.shared.reachabilityStatus == .none {
            callback(.failure(CustomError.noNetwork))
            return nil
        }
        let repoPublisher = URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let httpResponse = output.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                      }
                    return output.data
            }
            .decode(
                type: T.self,
                decoder: JSONDecoder()
            )
            .receive(on: DispatchQueue.main)

        return repoPublisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("error")
                    callback(.failure(error))
                case .finished:
                    print("Success")
                }
            },
            receiveValue: { result in
                print("receive value")
                callback(.success(result))
            }
        )
    }
    
}

