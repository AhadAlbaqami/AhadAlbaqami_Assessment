//
//  LoginServiceManager.swift
//  AhadAlbaqami_Assessment
//
//  Created by Ahad Albaqami on 9/18/24.
//

import Foundation
import Moya

class LoginServiceManager: BaseServiceManager<LoginServiceAPI> {
    func signIn(params: [String: Any], completion: @escaping (Result<Token, NetworkError>) -> Void) {
        request(.signIn(params: params), completion: completion)
    }
}
