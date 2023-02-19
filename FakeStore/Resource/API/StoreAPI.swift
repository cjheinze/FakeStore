//
//  StoreAPI.swift
//  FakeStore
//
//  Created by Carl-Johan Heinze on 2023-02-19.
//

import Foundation

enum APIError: Error {
    case transportError
    case httpError(code: Int)
    case noData
    case parseError
}

struct StoreAPI {
    
    private let session = URLSession.shared
    
    func getProductsWithCallback(completion: @escaping (Result<[Product], Error>) -> Void) {
        let endpoint = StoreEndpoint.getProducts
        let request = URLRequest(url: endpoint.url)
        
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(APIError.transportError))
                return
            }
            
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(.failure(APIError.httpError(code: response.statusCode)))
                return
            }
            
            guard let data else {
                completion(.failure(APIError.noData))
                return
            }
            
            if let products = try? JSONDecoder().decode([Product].self, from: data) {
                completion(.success(products))
                return
            } else {
                completion(.failure(APIError.parseError))
            }
        }
        task.resume()
    }
}
