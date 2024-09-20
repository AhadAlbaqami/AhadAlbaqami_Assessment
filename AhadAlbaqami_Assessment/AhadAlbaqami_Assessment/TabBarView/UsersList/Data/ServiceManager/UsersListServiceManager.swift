//
//  UsersListServiceManager.swift
//  AhadAlbaqami_Assessment
//
//  Created by Ahad Albaqami on 9/18/24.
//

import Foundation
import Moya

class UsersListServiceManager: BaseServiceManager<UsersListAPI> {
    func getUsersList(completion: @escaping (Result<[UsersList], NetworkError>) -> Void) {
        request(.getUsersList, completion: completion)
    }
}
