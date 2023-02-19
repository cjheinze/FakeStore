//
//  ContentView.swift
//  FakeStore
//
//  Created by Carl-Johan Heinze on 2023-02-19.
//

import SwiftUI

struct ContentView: View {

    @StateObject var store = ProductStore.shared
    
    var body: some View {
        
        ScrollView {
            LazyVStack {
                ForEach(store.products, id: \.id) { product in
                    ProductListView(product: product)
                }
            }
        }
            
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
