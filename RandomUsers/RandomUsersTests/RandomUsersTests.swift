//
//  RandomUsersTests.swift
//  RandomUsersTests
//
//  Created by Rilassi Jordan on 06/01/2022.
//

import XCTest
import Combine
@testable import RandomUsers

class RandomUsersTests: XCTestCase {
    func testLoadUserBatchSuccess() throws {
        let homePresenterMock = HomePresenterMock()
        var userAPIService = UserAPIServiceMock()
        userAPIService.mockUsers = User.generateMockUserBatch()
        let homeInteractor = HomeInteractor(userService: userAPIService, presenter: homePresenterMock)
        homeInteractor.loadUserBatch()
        
        XCTAssertEqual(homePresenterMock.presentUsersCount, 1)
        XCTAssertNotNil(homePresenterMock.homeUsersResponse)
        XCTAssertEqual(homePresenterMock.homeUsersResponse!.users.count, 10)
    }

    func testLoadUserBatchError() throws {
        let homePresenterMock = HomePresenterMock()
        var userAPIService = UserAPIServiceMock()
        userAPIService.customError = .failToLoadUsers
        userAPIService.shouldSucceed = false
        let homeInteractor = HomeInteractor(userService: userAPIService, presenter: homePresenterMock)
        homeInteractor.loadUserBatch()
        
        XCTAssertEqual(homePresenterMock.presentUsersCount, 0)
        XCTAssertEqual(homePresenterMock.presentErrorCount, 1)
        XCTAssertNotNil(homePresenterMock.homeErrorResponse)
        XCTAssertEqual(homePresenterMock.homeErrorResponse!.error, .failToLoadUsers)
        XCTAssertEqual(homePresenterMock.homeErrorResponse!.error.customMessage, "Erreur lors du chargement des utilisateurs.")
    }
    
    func testLoadUserNoNetwork() throws {
        let homePresenterMock = HomePresenterMock()
        var userAPIService = UserAPIServiceMock()
        userAPIService.customError = .noNetwork
        userAPIService.shouldSucceed = false
        let homeInteractor = HomeInteractor(userService: userAPIService, presenter: homePresenterMock)
        homeInteractor.loadUserBatch()
        
        XCTAssertEqual(homePresenterMock.presentUsersCount, 1)
        XCTAssertEqual(homePresenterMock.presentErrorCount, 1)
        XCTAssertNotNil(homePresenterMock.homeErrorResponse)
        XCTAssertEqual(homePresenterMock.homeErrorResponse!.error, .noNetwork)
        XCTAssertEqual(homePresenterMock.homeErrorResponse!.error.customMessage, "Pas de connexion réseau.")
    }
    
    func testReloadUsers() throws {
        let homePresenterMock = HomePresenterMock()
        var userAPIService = UserAPIServiceMock()
        userAPIService.mockUsers = User.generateMockUserBatch()
        userAPIService.mockUsers.append(contentsOf: User.generateMockUserBatch())
        let homeInteractor = HomeInteractor(userService: userAPIService, presenter: homePresenterMock)
        homeInteractor.loadUserBatch()
        
        XCTAssertEqual(homePresenterMock.presentUsersCount, 1)
        XCTAssertNotNil(homePresenterMock.homeUsersResponse)
        XCTAssertEqual(homePresenterMock.homeUsersResponse!.users.count, 20)
        
        userAPIService.mockUsers = User.generateMockUserBatch()
        homeInteractor.reloadAllUsers()
        
        XCTAssertEqual(homePresenterMock.presentUsersCount, 2)
    }
    
    func testUserToDisplay() throws {
        let homePresenterMock = HomePresenterMock()
        var userAPIService = UserAPIServiceMock()
        userAPIService.mockUsers = User.generateMockUserBatch()
        let homeInteractor = HomeInteractor(userService: userAPIService, presenter: homePresenterMock)
        homeInteractor.loadUserBatch()
        homeInteractor.userToDisplay(request: Home.UserToDisplay.Request(index: 9))
        
        XCTAssertEqual(homePresenterMock.presentUserToDisplayCount, 1)
        XCTAssertNotNil(homeInteractor.userToDisplay)
    }
    
    func testUserToDisplayWrongIndex() throws {
        let homePresenterMock = HomePresenterMock()
        var userAPIService = UserAPIServiceMock()
        userAPIService.mockUsers = User.generateMockUserBatch()
        let homeInteractor = HomeInteractor(userService: userAPIService, presenter: homePresenterMock)
        homeInteractor.loadUserBatch()
        homeInteractor.userToDisplay(request: Home.UserToDisplay.Request(index: 10))
        
        XCTAssertEqual(homePresenterMock.presentUserToDisplayCount, 0)
        XCTAssertEqual(homePresenterMock.presentErrorCount, 1)
        XCTAssertNotNil(homePresenterMock.homeErrorResponse)
        XCTAssertEqual(homePresenterMock.homeErrorResponse!.error, .unknownError)
        XCTAssertNil(homeInteractor.userToDisplay)
    }
}

// Mock classes

struct UserAPIServiceMock: UserAPIServiceProtocol {
    var shouldSucceed = true
    var mockUsers: [User] = []
    var customError: CustomError?
    func getUsers(_ getUsersRequest: GetUsersRequest, completion: @escaping APIServiceCompletion<GetUsersResponse>) -> Cancellable? {
        guard shouldSucceed else {
            let customError = customError ?? .unknownError
            completion(.failure(customError))
            return nil
        }
        
        let getUsersReponse = GetUsersResponse(results: mockUsers)
        completion(.success(getUsersReponse))
        return nil
    }
}

class HomePresenterMock: HomePresentationLogic {
    var presentUsersCount = 0
    var homeUsersResponse: Home.Users.Response?
    func presentUsers(response: Home.Users.Response) {
        presentUsersCount += 1
        homeUsersResponse = response
    }
    
    var presentErrorCount = 0
    var homeErrorResponse: Home.Error.Response?
    func presentError(response: Home.Error.Response) {
        presentErrorCount += 1
        homeErrorResponse = response
    }
    
    var presentUserToDisplayCount = 0
    func presentUserToDisplay() {
        presentUserToDisplayCount += 1
    }
}
