//
//  loginUnitTest.swift
//  AhadAlbaqami_AssessmentTests
//
//  Created by Ahad Albaqami on 9/18/24.
//

import XCTest
@testable import AhadAlbaqami_Assessment

class LoginViewModelTests: XCTestCase {
    var viewModel: LoginViewModel!
    var mockLoginService: MockLoginServiceManager!
    
    override func setUp() {
        super.setUp()
        mockLoginService = MockLoginServiceManager()
        viewModel = LoginViewModel()
        viewModel.userService = mockLoginService
    }
    
    override func tearDown() {
        viewModel = nil
        mockLoginService = nil
        super.tearDown()
    }
    
    func testValidationSucceeded() {
        viewModel.username = "Ahad"
        XCTAssertTrue(viewModel.isUsernameValid, "Username should be valid.")
        viewModel.password = "Abc@123"
        XCTAssertTrue(viewModel.isPasswordValid, "Password should be valid.")
    }

    func testValidationFailed() {
        viewModel.username = "Ah"
        XCTAssertFalse(viewModel.isUsernameValid, "Username should be invalid, must contain at least 3 characters.")
        viewModel.password = "abc12"
        XCTAssertFalse(viewModel.isPasswordValid, "Password should be invalid, must contain an uppercase letter and a special character.")
    }
    
    func testLoginUserSuccess() {
        mockLoginService.loginResult = .success(Token(token: "abc123"))
        let expectation = self.expectation(description: "Login success")
        
        viewModel.signIn()
        
        DispatchQueue.main.async {
            XCTAssertTrue(self.viewModel.isAuthenticated, "User should be authenticated on successful login.")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testLoginUserFailure() {
        let nsError = NSError(domain: "com.ahadalbaqami.assessment.error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed due to network issue"])
        mockLoginService.loginResult = .failure(NetworkError.genericError(nsError))
        let expectation = self.expectation(description: "Login failure")
        
        viewModel.signIn()
        
        DispatchQueue.main.async {
            XCTAssertFalse(self.viewModel.isAuthenticated, "User should not be authenticated on login failure.")
            XCTAssertTrue(self.viewModel.showingError, "Error message should be shown on login failure.")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}


class MockLoginServiceManager: LoginServiceManager {
    var loginResult: Result<Token, NetworkError>?
    
    override func signIn(params: [String: Any], completion: @escaping (Result<Token, NetworkError>) -> Void) {
        if let result = loginResult {
            completion(result)
        } else {
            completion(.failure(.custom("No result set")))
        }
    }
}

