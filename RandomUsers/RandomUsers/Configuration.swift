//
//  Configuration.swift
//  RandomUsers
//
//  Created by Rilassi Jordan on 07/01/2022.
//

import Foundation

struct Environment {
    static var hostBaseURLPath: String {
        "https://randomuser.me/api/"
    }
}

enum CollectionViewCells: String {
    case homeUserCell = "HomeUserCell"
    case activityIndicatorCell = "ActivityIndicatorCell"
}
