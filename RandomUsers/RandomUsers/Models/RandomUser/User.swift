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
    let dob: DateOfBirth
    let picture: Picture
}

struct Name: Codable {
    let title: String
    let first: String
    let last: String
}

struct DateOfBirth: Codable {
    let date: String
    let age: Int
}

struct Picture: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}

