//
//  HomePresenter.swift
//  RandomUsers
//
//  Created by Rilassi Jordan.

import UIKit

protocol HomePresentationLogic
{
    func presentSomething(response: Home.Users.Response)
}

class HomePresenter: HomePresentationLogic
{
    weak var viewController: HomeDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: Home.Users.Response)
    {
        let userViewModels = response.users.map { UserViewModel(user: $0) }
        let viewModel = Home.Users.ViewModel(usersViewModel: userViewModels)
        viewController?.displayUsers(viewModel: viewModel)
    }
}
