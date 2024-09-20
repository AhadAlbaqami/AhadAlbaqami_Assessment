//
//  BaseServiceManager.swift
//  AhadAlbaqami_Assessment
//
//  Created by Ahad Albaqami on 9/18/24.
//

import Foundation
import Moya

public class BaseServiceManager<T: TargetType> {
    var provider: MoyaProvider<T>
    
    init(provider: MoyaProvider<T> = MoyaProvider<T>()) {
        self.provider = provider
    }
    
    func request<D: Decodable>(_ target: T, completion: @escaping (Result<D, NetworkError>) -> Void) {
        provider.request(target) { result in
            switch result {
            case .success(let response):
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let data = try decoder.decode(D.self, from: response.data)
                    completion(.success(data))
                } catch {
                    completion(.failure(.custom("Failed to decode response.")))
                }
            case .failure(let moyaError):
                let error = self.mapMoyaErrorToCustomError(moyaError: moyaError)
                completion(.failure(error))
            }
        }
    }
    
    private func mapMoyaErrorToCustomError(moyaError: MoyaError) -> NetworkError {
        switch moyaError {
        case let .statusCode(response):
            switch response.statusCode {
            case 401:
                return .unauthorized
            case 500...599:
                return .serverError
            default:
                return .custom("Something went wrong")
            }
        case .imageMapping(_), .jsonMapping(_), .stringMapping(_), .objectMapping(_, _):
            return .network(description: "Data decoding error.")
        case .requestMapping:
            return .network(description: "Request mapping error.")
        case .underlying(let error, _):
            return .network(description: error.localizedDescription)
        case .encodableMapping(let error):
            return .network(description: error.localizedDescription)
        case .parameterEncoding(let error):
            return .network(description: error.localizedDescription)
        }
    }
}
