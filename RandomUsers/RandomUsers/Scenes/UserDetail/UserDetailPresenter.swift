//
//  UserDetailPresenter.swift
//  RandomUsers
//
//  Created by Rilassi Jordan.

import UIKit

protocol UserDetailPresentationLogic
{
    func presentUserDetail(response: UserDetail.UserDetailModel.Response)
}

class UserDetailPresenter: UserDetailPresentationLogic
{
    weak var viewController: UserDetailDisplayLogic?
    
    // MARK: Present User Detail
    
    func presentUserDetail(response: UserDetail.UserDetailModel.Response)
    {
        let userDetailViewModel = UserDetailViewModel(user: response.user)
        let viewModel = UserDetail.UserDetailModel.ViewModel(userDetailViewModel: userDetailViewModel)
        viewController?.displayUserDetail(viewModel: viewModel)
    }
}
