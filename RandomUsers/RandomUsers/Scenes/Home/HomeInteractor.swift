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
                self?.saveUsersLocally()
                
                let response = Home.Users.Response(users: response.results)
                self?.presenter?.presentUsers(response: response)
            case .failure(let error):
                let customError = error as? CustomError ?? CustomError.unknownError
                if self?.users.isEmpty == true && customError == .noNetwork {
                    self?.loadLocalUsers()
                }
                let response = Home.Error.Response(error: customError)
                self?.presenter?.presentError(response: response)
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
    
    private func loadLocalUsers() {
        users = getLocalUsers()
        let response = Home.Users.Response(users: users)
        presenter?.presentUsers(response: response)
    }
    
    private func saveUsersLocally() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(users)
            UserDefaults.standard.set(data, forKey: UserDefaultsKeys.users.rawValue)
        } catch {
            print("Unable to encode users : \(error)")
        }
    }
    
    private func getLocalUsers() -> [User] {
        guard let data = UserDefaults.standard.data(forKey: UserDefaultsKeys.users.rawValue) else { return [] }
        do {
            let decoder = JSONDecoder()
            let localUsers = try decoder.decode([User].self, from: data)
            return localUsers
        } catch {
            print("Unable to decode users : \(error)")
            return []
        }
    }
}
