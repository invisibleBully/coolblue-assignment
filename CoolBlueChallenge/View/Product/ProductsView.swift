//
//  ProductsView.swift
//  CoolBlueChallenge
//
//  Created by Jude on 08/08/2022.
//

import SwiftUI

struct ProductsView: View {
    
    @StateObject var productData =  ProductViewModel()
    
    var body: some View {
        NavigationView {
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    HStack(spacing: 10) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color.gray)
                        TextField("Search Products", text: $productData.searchQuery)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.white)
                    .shadow(color: .black.opacity(0.06), radius: 5, x: 5, y: 5)
                    .shadow(color: .black.opacity(0.06), radius: 5, x: -5, y: -5)
                }
                .padding()
                
                if let products = productData.fetchedProducts {
                    if products.isEmpty {
                        Text("No results...")
                            .padding(.top, 20)
                    }else{
                        ForEach(products){ product in
                            ProductRowView(product: product)
                        }
                    }
                }else{
                    if productData.searchQuery != "" {
                        ProgressView()
                            .padding(.top,20)
                    }
                }
            }.navigationTitle("Products")
        }
    }
}

struct ProductsHomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
