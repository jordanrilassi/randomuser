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
    func userToDisplay(request: Home.UserToDisplay.Request)
}

protocol HomeDataStore
{
    var userToDisplay: User? { get set }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore
{
    var presenter: HomePresentationLogic?
    var worker: HomeWorker
    var userToDisplay: User?
    
    fileprivate var users: [User] = []
    fileprivate var batchUsers: [User] = []
    fileprivate let userBatch = 10
    fileprivate var apiCancellable: Any?
    
    init(userService: UserAPIServiceProtocol) {
        worker = HomeWorker(userService: userService)
    }
    
    private var pageForBatch: Int {
        if users.isEmpty {
            return 0
        } else {
            return (users.count + userBatch) / userBatch
        }
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
                
                let response = Home.Users.Response(users: response.results)
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
    
    func userToDisplay(request: Home.UserToDisplay.Request) {
        userToDisplay = users[request.index]
        presenter?.presentUserToDisplay()
    }
}
