//
//  User.swift
//  RandomUsers
//
//  Created by Rilassi Jordan on 06/01/2022.
//

import Foundation

struct User: Codable {
    let gender: String
    let name: Name
    let email: String
    let phone: String
    let cell: String
    let location: Location
}
