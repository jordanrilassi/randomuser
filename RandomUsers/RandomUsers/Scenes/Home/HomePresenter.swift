//
//  HomePresenter.swift
//  RandomUsers
//
//  Created by Rilassi Jordan.

import UIKit

protocol HomePresentationLogic
{
    func presentUsers(response: Home.Users.Response)
    func presentError(response: Home.Error.Response)
    func presentUserToDisplay()
}

class HomePresenter: HomePresentationLogic
{
    weak var viewController: HomeDisplayLogic?
    
    // MARK: Do something
    
    func presentUsers(response: Home.Users.Response)
    {
        let userViewModels = response.users.map { UserViewModel(user: $0) }
        let viewModel = Home.Users.ViewModel(usersViewModel: userViewModels)
        viewController?.displayUsers(viewModel: viewModel)
    }
    
    func presentError(response: Home.Error.Response) {
        let errorViewModel = Home.Error.ViewModel.ErrorViewModel(title: "Erreur", message: response.error.customMessage)
        let viewModel = Home.Error.ViewModel(errorViewModel: errorViewModel)
        viewController?.displayError(viewModel: viewModel)
    }
    
    func presentUserToDisplay() {
        viewController?.displayUserToDisplay()
    }
}
