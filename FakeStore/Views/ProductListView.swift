//
//  ProductListView.swift
//  FakeStore
//
//  Created by Carl-Johan Heinze on 2023-02-19.
//

import SwiftUI
import CachedAsyncImage

struct ProductListView: View {
    @State var showBuyAlert = false
    var product: Product
    
    var body: some View {
        ZStack {
            CachedAsyncImage(url: URL(string: product.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
            } placeholder: {
                ProgressView()
            }
            
            VStack {
                Spacer()
                
                HStack{
                    VStack(alignment: .leading, spacing: 6) {
                        
                        Text(product.title)
                            .bold()
                            .lineLimit(1)
                        
                        HStack(spacing: 2) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("\(product.rating.formattedRate)")
                            Text("(\(product.rating.count))")
                            Spacer()
                        }
                        
                    }
                    Button(product.formattedPrice) {
                        showBuyAlert = true
                    }
                    .buttonStyle(.bordered)
                    .bold()
                    .alert("Oops!", isPresented: $showBuyAlert) {
                        Button("OK", role: .cancel) { }
                    } message: {
                        Text("Not yet implemented, also this is all fake :)")
                    }
                }
                .padding()
                .background(.thinMaterial)
            }
        }
        .frame(height: 300)
        .background(.regularMaterial)
        .cornerRadius(20)
        .padding()
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(product: Product(id: 1, title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops", price: 109.95, description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday", category: .mensClothing, image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg", rating: Rating(rate: 3.9, count: 120)))
    }
}
