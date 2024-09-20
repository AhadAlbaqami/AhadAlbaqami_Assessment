//
//  NetworkEnums.swift
//  AhadAlbaqami_Assessment
//
//  Created by Ahad Albaqami on 9/18/24.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case unauthorized
    case serverError
    case custom(String)
    case network(description: String)
    case genericError(Error)
    
    var localizedDescription: String {
        switch self {
        case .unauthorized:
            return "You need to log in to continue."
        case .serverError:
            return "Server encountered an error."
        case .custom(let message):
            return message
        case .network(let description):
            return description
        case .genericError(let error):
            return error.localizedDescription
        }
    }
}
