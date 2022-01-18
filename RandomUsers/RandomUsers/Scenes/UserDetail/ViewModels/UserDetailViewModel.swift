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
    let infoUser: String
    let address: String
    let email: String
    let phone: String
    let cell: String
    let pictureUrlString: String
    
    init(user: User) {
        gender = user.gender
        title = user.name.title
        fullname = "\(user.name.first) \(user.name.last)"
        infoUser = "\(user.name.title) \(fullname), \(user.dob.age) ans"
        address = "\(user.location?.street.number ?? 0) \(user.location?.street.name ?? "")\n\(user.location?.postcode ?? "") \(user.location?.city ?? "")\n\(user.location?.country ?? "")"
        email = user.email
        phone = user.phone
        cell = user.cell
        pictureUrlString = user.picture.large
    }
}
