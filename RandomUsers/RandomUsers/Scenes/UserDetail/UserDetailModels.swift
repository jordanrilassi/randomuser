//
//  UserDetailModels.swift
//  RandomUsers
//
//  Created by Rilassi Jordan.

import UIKit

enum UserDetail {
    // MARK: Use cases
    
    enum UserDetailModel {
        struct Response {
            let user: User
        }
        struct ViewModel {
            let userDetailViewModel: UserDetailViewModel
        }
    }
}
