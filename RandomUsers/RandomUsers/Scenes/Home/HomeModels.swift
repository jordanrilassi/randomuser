//
//  HomeModels.swift
//  RandomUsers
//
//  Created by Rilassi Jordan.

import UIKit

enum Home {
    // MARK: Use cases
    
    enum Users {
        struct Response {
            let users: [User]
        }
        struct ViewModel {
            let usersViewModel: [UserViewModel]
        }
    }
    
    enum Error {
        struct Response {
            let error: CustomError
        }
        struct ViewModel {
            let errorViewModel: ErrorViewModel
            
            struct ErrorViewModel {
                let title: String
                let message: String
            }
        }
    }
    
    enum UserToDisplay {
        struct Request {
            let index: Int
        }
    }
}
