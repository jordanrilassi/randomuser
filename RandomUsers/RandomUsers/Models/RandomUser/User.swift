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
    let location: Location?
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

extension User {
    static func generateMockUser() -> User {
        return User(gender: "male",
                    name: Name(title: "mr", first: "John", last: "Doe"),
                    email: "email@emil.com",
                    phone: "",
                    cell: "",
                    location: nil,
                    dob: DateOfBirth(date: "", age: 30),
                    picture: Picture(large: "", medium: "", thumbnail: ""))
    }
    
    static func generateMockUserBatch() -> [User] {
        var users: [User] = []
        for _ in 1...10 { users.append(User.generateMockUser()) }
        return users
    }
}
