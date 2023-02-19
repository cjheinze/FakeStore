//
//  ProductStore.swift
//  FakeStore
//
//  Created by Carl-Johan Heinze on 2023-02-19.
//

import Foundation

class ProductStore: ObservableObject {
    static var shared = ProductStore()
    
    @Published var products: [Product] = [] {
        didSet {
            print(products)
        }
    }
    var error: Error?
    
    internal init() {
        StoreAPI().getProductsWithCallback { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self?.products = success
                case .failure(let failure):
                    self?.error = failure
                }
            }
        }
    }
}
