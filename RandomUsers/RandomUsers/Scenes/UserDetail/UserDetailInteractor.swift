//
//  UserDetailInteractor.swift
//  RandomUsers
//
//  Created by Rilassi Jordan.

import UIKit

protocol UserDetailBusinessLogic
{
    func getUserDetail()
}

protocol UserDetailDataStore
{
    var user: User? { get set }
}

class UserDetailInteractor: UserDetailBusinessLogic, UserDetailDataStore
{
    var presenter: UserDetailPresentationLogic?
    var user: User?
    
    // MARK: Get User Detail
    
    func getUserDetail()
    {
        guard let user = user else { return }
        
        let response = UserDetail.UserDetailModel.Response(user: user)
        presenter?.presentUserDetail(response: response)
    }
}
