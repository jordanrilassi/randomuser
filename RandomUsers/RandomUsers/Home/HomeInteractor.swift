//
//  HomeInteractor.swift
//  RandomUsers
//
//  Created by Rilassi Jordan.

import UIKit

protocol HomeBusinessLogic
{
    func loadUserBatch()
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
            case .failure(let error):
                // Hanlde error
                break
            }
        }
        apiCancellable = cancellable
        let response = Home.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
