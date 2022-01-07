//
//  GetUsersRequest.swift
//  RandomUsers
//
//  Created by Rilassi Jordan on 07/01/2022.
//

import Foundation

struct GetUsersRequest: Codable {
    let page: Int
    let count: Int
}
