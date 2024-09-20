//
//  API.swift
//  AhadAlbaqami_Assessment
//
//  Created by Ahad Albaqami on 9/18/24.
//

import Foundation
import Moya

enum UsersListAPI {
    case getUsersList
}

extension UsersListAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .getUsersList:
            return URL(string: "https://pastebin.com/raw/wgkJgazE")!
        }
    }
    
    var path: String {
        switch self {
        case .getUsersList:
            return ""
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUsersList:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getUsersList:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var sampleData: Data {
        return Data()
    }
}
