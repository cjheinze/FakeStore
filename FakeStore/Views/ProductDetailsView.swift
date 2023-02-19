//
//  ProductDetailsView.swift
//  FakeStore
//
//  Created by Carl-Johan Heinze on 2023-02-19.
//

import SwiftUI
import CachedAsyncImage

struct ProductDetailsView: View {
    var product: Product
    
    var body: some View {
        VStack {
            Text(product.title)
                .font(.title)
            CachedAsyncImage(url: URL(string: product.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
            } placeholder: {
                ProgressView()
            }
            .frame(height: 300)
            Text(product.description)
        }
        .padding()
        .navigationTitle(product.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProductDetailsView(product: Product(id: 3, title: "Mens Cotton Jacket", price: 55.99, description: "great outerwear jackets for Spring/Autumn/Winter, suitable for many occasions, such as working, hiking, camping, mountain/rock climbing, cycling, traveling or other outdoors. Good gift choice for you or your family member. A warm hearted love to Father, husband or son in this thanksgiving or Christmas Day.", category: Category.mensClothing, image: "https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg", rating: Rating(rate: 4.7, count: 500)))
        }
    }
}
