//
//  UserDetailRouter.swift
//  RandomUsers
//
//  Created by Rilassi Jordan.

import UIKit

@objc protocol UserDetailRoutingLogic
{

}

protocol UserDetailDataPassing
{
  var dataStore: UserDetailDataStore? { get }
}

class UserDetailRouter: NSObject, UserDetailRoutingLogic, UserDetailDataPassing
{
  weak var viewController: UserDetailViewController?
  var dataStore: UserDetailDataStore?
  
  // MARK: Routing

  // MARK: Navigation
  
  // MARK: Passing data
}
