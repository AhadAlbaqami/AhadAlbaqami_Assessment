//
//  UserListUnitTest.swift
//  AhadAlbaqami_AssessmentTests
//
//  Created by Ahad Albaqami on 9/18/24.
//

import XCTest
@testable import AhadAlbaqami_Assessment

class UsersListViewModelTests: XCTestCase {
    var viewModel: TestableUsersListViewModel!
    var mockService: MockUsersListServiceManager!
    
    override func setUp() {
        super.setUp()
        mockService = MockUsersListServiceManager()
        viewModel = TestableUsersListViewModel()
        viewModel.testUserService = mockService
    }
    
    func testFetchUsersSuccess() {
        let user = UsersList(
            id: "1",
            createdAt: .now,
            width: 100,
            height: 100,
            color: "Green",
            likes: 10,
            likedByUser: false,
            user: User(
                id: "43800",
                username: "ahadAlbaqami1",
                name: "Ahad Albaqami",
                profileImage: ProfileImage(small: "https://images.unsplash.com/profile-1464495186405-68089dcd96c3?ixlib=rb-0.3.5/u0026q=80/u0026fm=jpg/u0026crop=faces/u0026fit=crop/u0026h=32/u0026w=32/u0026s=63f1d805cffccb834cf839c719d91702", medium: "https://images.unsplash.com/profile-1464495186405-68089dcd96c3?ixlib=rb-0.3.5/u0026q=80/u0026fm=jpg/u0026crop=faces/u0026fit=crop/u0026h=64/u0026w=64/u0026s=ef631d113179b3137f911a05fea56d23", large: "https://images.unsplash.com/profile-1464495186405-68089dcd96c3?ixlib=rb-0.3.5/u0026q=80/u0026fm=jpg/u0026crop=faces/u0026fit=crop/u0026h=128/u0026w=128/u0026s=622a88097cf6661f84cd8942d851d9a2"),
                links: UserLinks(linksSelf: "https://api.unsplash.com/users/llyn", html: "http://unsplash.com/@llyn", photos: "https://api.unsplash.com/users/llyn/photos", likes: "https://api.unsplash.com/users/llyn/likes")
            ),
     
            currentUserCollections: [],
            urls: Urls(raw: "https://images.unsplash.com/photo-1464550580740-b3f73fd373cb", full: "https://images.unsplash.com/photo-1464550580740-b3f73fd373cb?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=aff4510c05325ad3c7b07ed7062b10c5", regular: "https://images.unsplash.com/photo-1464550580740-b3f73fd373cb?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&w=1080&fit=max&s=899c346de4765f353375b8a5bd6cfc0e", small: "https://images.unsplash.com/photo-1464550580740-b3f73fd373cb?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&w=400&fit=max&s=45615ee5fff6def6ab2e3b9e8883656f", thumb: "https://images.unsplash.com/photo-1464550580740-b3f73fd373cb?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&w=200&fit=max&s=32eedaa5d930578ff89cff9195472650"),
            categories: [],
            links: WelcomeLinks(linksSelf: "https://api.unsplash.com/photos/4kQA1aQK8-Y", html: "http://unsplash.com/photos/4kQA1aQK8-Y", download: "http://unsplash.com/photos/4kQA1aQK8-Y/download")
        )
        
        mockService.mockResult = .success([user])
        
        viewModel.fetchUsersList()
        
        let exp = expectation(description: "Fetch Users")
        DispatchQueue.main.async {
            exp.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
        
        XCTAssertEqual(viewModel.usersListArray.count, 1)
        XCTAssertEqual(viewModel.usersListArray.first?.id, "1")
    }
    
    func testFetchUsersFailure() {
        mockService.mockResult = .failure(.custom("Network error"))
        
        viewModel.fetchUsersList()
        
        let exp = expectation(description: "Fetch Users Failure")
        DispatchQueue.main.async {
            exp.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
        
        XCTAssertTrue(viewModel.usersListArray.isEmpty)
        XCTAssertTrue(viewModel.showingError)
        XCTAssertEqual(viewModel.errorMessage, "Network error")
    }
}



class MockUsersListServiceManager: UsersListServiceManager {
    var mockResult: Result<[UsersList], NetworkError>?
    
    override func getUsersList(completion: @escaping (Result<[UsersList], NetworkError>) -> Void) {
        if let result = mockResult {
            completion(result)
        }
    }
    
}

class TestableUsersListViewModel: UsersListViewModel {
    var testUserService: UsersListServiceManager?
    
    override func fetchUsersList() {
        isLoading = true
        
        testUserService?.getUsersList { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    self?.errorMessage = ""
                    self?.usersListArray = response
                case .failure(let error):
                    self?.showingError = true
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
