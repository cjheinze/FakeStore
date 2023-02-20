//
//  ContentView.swift
//  FakeStore
//
//  Created by Carl-Johan Heinze on 2023-02-19.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject var model = ListViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(model.filteredProducts, id: \.id) { product in
                        NavigationLink(value: product) {
                            ProductListView(product: product)
                        }
                    }
                }
            }
            .searchable(text: $model.searchText, tokens: $model.categoryTokens, suggestedTokens: $model.suggestions) { token in
                switch token {
                case .electronics: Text("Electronics⚡️")
                case .mensClothing: Text("Men's clothes 👔")
                case .womensClothing: Text("Women's clothes 👚")
                case .jewelery: Text("Jewelry 💍")
                default: Text("Other")
                }
            }
            .navigationDestination(for: Product.self, destination: { ProductDetailsView(product: $0) })
            .navigationTitle(Text("FakeStore"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
