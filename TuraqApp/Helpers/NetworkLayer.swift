//
//  NetworkLayer.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 05.04.2023.
//

import Alamofire

enum NetworkError: Error {
    case invalidUrl(message: String)
    case invalidResponse
    case serverError(message: String)
    case decodingError(message: String)
    case unknownError(message: String)
}

struct ErrorMessage: Codable {
    let message: String
}

final class NetworkLayer {
    
    static let shared = NetworkLayer()
    static var token = ""
//    private let baseURL = "http://100.107.195.21:8080/"
    private let baseURL = "http://185.129.50.69:8080/"
    
    private init() {}
    
    func request(endpoint: String,
                 method: HTTPMethod = .get,
                 parameters: Parameters? = nil,
                 encoding: ParameterEncoding = URLEncoding.default,
                 headers: HTTPHeaders? = nil,
                 completion: @escaping (Result<Data, NetworkError>) -> Void) {
        
        let url = baseURL + endpoint
        AF.request(url,
                   method: method,
                   parameters: parameters,
                   encoding: encoding,
                   headers: headers)
        .validate()
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                if let data = try? JSONSerialization.data(withJSONObject: value) {
                    completion(.success(data))
                } else {
                    completion(.failure(NetworkError.invalidResponse))
                }
            case .failure(let error):
                if let data = response.data,
                   let message = try? JSONDecoder().decode(ErrorMessage.self, from: data).message {
                    completion(.failure(NetworkError.serverError(message: message)))
                } else {
                    completion(.failure(NetworkError.decodingError(message: error.localizedDescription)))
                }
            }
        }
    }
    
    func request<T: Decodable>(
        responseModel: T.Type,
        endpoint: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        
        let url = baseURL + endpoint
        AF.request(url,
                   method: method,
                   parameters: parameters,
                   encoding: encoding,
                   headers: headers)
        .validate()
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                if let data = try? JSONSerialization.data(withJSONObject: value) {
                    let decoder = JSONDecoder()
                    do {
                        let model = try decoder.decode(T.self, from: data)
                        completion(.success(model))
                    } catch {
                        completion(.failure(NetworkError.decodingError(message: error.localizedDescription)))
                    }
                } else {
                    completion(.failure(NetworkError.invalidResponse))
                }
            case .failure(let error):
                if let data = response.data,
                   let message = try? JSONDecoder().decode(ErrorMessage.self, from: data).message {
                    completion(.failure(NetworkError.serverError(message: message)))
                } else {
                    completion(.failure(NetworkError.decodingError(message: error.localizedDescription)))
                }
            }
        }
    }
}
