//
//  UserDetailViewModel.swift
//  RandomUsers
//
//  Created by Rilassi Jordan on 10/01/2022.
//

import Foundation

struct UserDetailViewModel {
    let gender: String
    let title: String
    let fullname: String
    let email: String
    let phone: String
    let cell: String
    let age: String
    let picture: Picture
    
    init(user: User) {
        gender = user.gender
        title = user.name.title
        fullname = "\(user.name.first) \(user.name.last)"
        email = user.email
        phone = user.phone
        cell = user.cell
        age = "\(user.dob.age) ans"
        picture = user.picture
    }
}
