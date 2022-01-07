//
//  UserViewModel.swift
//  RandomUsers
//
//  Created by Rilassi Jordan on 07/01/2022.
//

import Foundation

struct UserViewModel {
    let fullname: String
    
    init(user: User) {
        fullname = "\(user.name.first) \(user.name.last)"
    }
}
