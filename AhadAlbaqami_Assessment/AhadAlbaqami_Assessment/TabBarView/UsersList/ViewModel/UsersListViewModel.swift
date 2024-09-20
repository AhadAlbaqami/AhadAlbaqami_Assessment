//
//  UsersListViewModel.swift
//  AhadAlbaqami_Assessment
//
//  Created by Ahad Albaqami on 9/18/24.
//

import Foundation
import Combine

class UsersListViewModel: BaseViewModel {
    @Published var usersListArray: [UsersList] = []
    private let userService: UsersListServiceManager = UsersListServiceManager()
    
    func fetchUsersList() {
        isLoading = true
        userService.getUsersList { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    self?.usersListArray = response
                    print("response: \(response)")
                case .failure(let error):
                    self?.showingError = true
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
