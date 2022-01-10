//
//  HomeInteractor.swift
//  RandomUsers
//
//  Created by Rilassi Jordan.

import UIKit

protocol HomeBusinessLogic
{
    func loadUserBatch()
    func reloadAllUsers()
}

protocol HomeDataStore
{
    //var name: String { get set }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore
{
    var presenter: HomePresentationLogic?
    var worker: HomeWorker
    fileprivate var users: [User] = []
    fileprivate let userBatch = 10
    fileprivate var apiCancellable: Any?
    
    init(userService: UserAPIServiceProtocol) {
        worker = HomeWorker(userService: userService)
    }
    
    private var pageForBatch: Int {
        (users.count + userBatch) / userBatch
    }
    
    // MARK: Do something
    
    func loadUserBatch()
    {
        let getUsersRequest = GetUsersRequest(page: pageForBatch, count: userBatch)
        let cancellable = worker.loadUserBatch(getUsersRequest) { [weak self] result in
            switch result {
            case .success(let response):
                self?.users.append(contentsOf: response.results)
                self?.apiCancellable = nil
                
                guard let users = self?.users else { return }
                let response = Home.Users.Response(users: users)
                self?.presenter?.presentUsers(response: response)
            case .failure(_):
                // Hanlde error
                break
            }
        }
        apiCancellable = cancellable
    }
    
    func reloadAllUsers() {
        users.removeAll()
        loadUserBatch()
    }
}
