//
//  ContentView.swift
//  FakeStore
//
//  Created by Carl-Johan Heinze on 2023-02-19.
//

import SwiftUI

struct ContentView: View {

    @StateObject var store = ProductStore.shared
    @State var categoryTokens: [Category] = []

    @State var searchText = ""
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(store.products.filter({ product in
                        guard !searchText.isEmpty || !categoryTokens.isEmpty else {
                            return true
                        }
                        return product.title.lowercased().contains(searchText.lowercased()) ||
                        categoryTokens.map(\.rawValue).contains(product.category.rawValue)
                    }), id: \.id) { product in
                        NavigationLink(value: product) {
                            ProductListView(product: product)
                        }
                    }
                }
            }
            .navigationDestination(for: Product.self, destination: { ProductDetailsView(product: $0) })
            .navigationTitle(Text("FakeStore"))
            .searchable(text: $searchText, tokens: $categoryTokens) { token in
                Text(token.rawValue)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
