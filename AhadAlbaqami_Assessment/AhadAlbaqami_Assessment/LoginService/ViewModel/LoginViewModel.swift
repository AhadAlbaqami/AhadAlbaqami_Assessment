//
//  LoginViewModel.swift
//  AhadAlbaqami_Assessment
//
//  Created by Ahad Albaqami on 9/18/24.
//

import Foundation
import Combine

class LoginViewModel: BaseViewModel {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isAuthenticated: Bool = false
    
    public var userService: LoginServiceManager = LoginServiceManager()
    
    var isUsernameValid: Bool {
        username.count >= 3
    }
    
    var isPasswordValid: Bool {
        let pattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@])[A-Za-z\\d@]{6,}$"
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: password)
    }
    
    var isFormValid: Bool {
        isUsernameValid && isPasswordValid
    }
}


//MARK: Network call
extension LoginViewModel {
    func signIn() {
        isLoading = true
        let params = ["username": username, "password": password]
        
        userService.signIn(params: params) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success( _):
                    self?.isAuthenticated = true
                case .failure(let error):
                    self?.showingError = true
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
