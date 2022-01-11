//
//  Configuration.swift
//  RandomUsers
//
//  Created by Rilassi Jordan on 07/01/2022.
//

import Foundation

enum Environment: String {
    case hostBaseURLPath = "https://randomuser.me/api/"
}

enum CollectionViewCells: String {
    case homeUserCell = "HomeUserCell"
    case activityIndicatorCell = "ActivityIndicatorCell"
}

enum UserDefaultsKeys: String {
    case users = "users"
}
