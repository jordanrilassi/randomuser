//
//  HomeRouter.swift
//  RandomUsers
//
//  Created by Rilassi Jordan.

import UIKit

@objc protocol HomeRoutingLogic {
    func routeToUserToDisplay()
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing {
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
    
    // MARK: Routing
    
    func routeToUserToDisplay() {
        let userDetailVC = UserDetailViewController()
        var userDetailDS = userDetailVC.router!.dataStore!
        passDataToUserDetail(source: dataStore!, destination: &userDetailDS)
        navigateToUserDetail(source: viewController!, destination: userDetailVC)
    }

    // MARK: Navigation
    
    func navigateToUserDetail(source: HomeViewController, destination: UserDetailViewController) {
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    
    func passDataToUserDetail(source: HomeDataStore, destination: inout UserDetailDataStore) {
        destination.user = source.userToDisplay
    }
}
