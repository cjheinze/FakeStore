//
//  StoreEndpoints.swift
//  FakeStore
//
//  Created by Carl-Johan Heinze on 2023-02-19.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var method: String { get }
    var url: URL { get }
}

struct StoreEndpoint: Endpoint {
    
    private let baseURL = URL(string: "https://fakestoreapi.com")!
    
    let path: String
    let method: String
    
    internal init(path: String, method: String = "GET") {
        self.path = path
        self.method = method
    }
    
    var url: URL {
        baseURL.appending(path: path)
    }
}

extension StoreEndpoint {
    static var getProducts: Endpoint {
        StoreEndpoint(path: "/products")
    }
    
    static func getProduct(with id: Int) -> Endpoint {
        StoreEndpoint(path: "/products/\(id)")
    }
}
