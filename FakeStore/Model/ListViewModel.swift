//
//  ListViewModel.swift
//  FakeStore
//
//  Created by Carl-Johan Heinze on 2023-02-20.
//

import Combine
import Foundation

class ListViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var categoryTokens: [Category] = [] {
        didSet {
            print("Did set tokens:", categoryTokens)
        }
    }
    @Published var suggestions: [Category] = Category.allCases.filter({ $0 != .unknown })

    @Published var productList: [Product] = []
    @Published var errorMessage: String = ""
    
    var filteredProducts: [Product] {
        guard !searchText.isEmpty || !categoryTokens.isEmpty else {
            return productList
        }

        return productList.filter { product in
            print("Tokens:", categoryTokens)
            let matchCategory = !categoryTokens.isEmpty
            if matchCategory {
                return categoryTokens.contains(product.category) && (searchText.isEmpty || product.title.lowercased().contains(searchText.lowercased()))
            } else {
                return product.title.lowercased().contains(searchText.lowercased())
            }
            
        }
    }

    private lazy var products: AnyPublisher<[Product], Error> = StoreAPI().getProductsPublisher()

    init(testEmptyState: Bool = false) {
        guard testEmptyState == false else {
            return
        }
        products
            .receive(on: DispatchQueue.main)
            .replaceError(with: [])
            .assign(to: &$productList)
        
        products
            .receive(on: DispatchQueue.main)
            .replaceError(with: [])
            .map({ $0.isEmpty ? "No products" : "" })
            .assign(to: &$errorMessage)
    }
}
