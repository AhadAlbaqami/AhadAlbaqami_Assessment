//
//  API.swift
//  AhadAlbaqami_Assessment
//
//  Created by Ahad Albaqami on 9/18/24.
//

import Foundation
import Moya

enum LoginServiceAPI {
    case signIn(params: [String: Any])
}

extension LoginServiceAPI: TargetType {
    
    var baseURL: URL {
        switch self {
        case .signIn:
            return URL(string: "https://20fc9164-96ce-460c-881e-4d254636120d.mock.pstmn.io")!
        }
    }
    
    var path: String {
        switch self {
        case .signIn:
            return "login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signIn:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .signIn(let params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var sampleData: Data {
        return Data()
    }
}
