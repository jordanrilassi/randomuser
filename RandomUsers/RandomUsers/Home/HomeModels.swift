//
//  HomeModels.swift
//  RandomUsers
//
//  Created by Rilassi Jordan.

import UIKit

enum Home
{
  // MARK: Use cases
  
  enum Users
  {
    struct Response
    {
        let users: [User]
    }
    struct ViewModel
    {
        let usersViewModel: [UserViewModel]
    }
  }
}
