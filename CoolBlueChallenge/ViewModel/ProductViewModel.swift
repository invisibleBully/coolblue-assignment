//
//  ProductViewModel.swift
//  CoolBlueChallenge
//
//  Created by Jude on 10/08/2022.
//

import SwiftUI
import Combine

class ProductViewModel: ObservableObject {
    
    @Published var searchQuery = ""
    @Published var currentPage = 1
    @Published var fetchedProducts: [Product]? = nil
    
    var searchCancellable: AnyCancellable? = nil
    var pageCount = 1
    var oldSearchQuery = ""
    let baseUrl = "https://bdk0sta2n0.execute-api.eu-west-1.amazonaws.com/mobile-assignment"
    
    
    init(){
        searchCancellable = $searchQuery
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str == "" {
                    self.fetchedProducts = nil
                }else{
                    self.fetchProducts()
                }
            })
    }
    
    
    func fetchProducts() {
        if searchQuery != oldSearchQuery{
            currentPage = 1
            oldSearchQuery = searchQuery
            self.fetchedProducts = nil
        }
        let urlString = "\(baseUrl)/search?query=\(searchQuery)&page=\(currentPage)"
        let session  = URLSession(configuration: .default)
        
        guard let url = URL(string: urlString) else { return }
        session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let apiData = data else {
                print("No data found...")
                return
            }
            
            do{
                let searchResults = try JSONDecoder().decode(ProductResponse.self, from: apiData)
                DispatchQueue.main.async {
                    if self.fetchedProducts == nil {
                        self.currentPage = searchResults.currentPage ?? 0
                        self.pageCount = searchResults.pageCount ?? 1
                        self.fetchedProducts = searchResults.products
                    } else {
                        var tempArray = self.fetchedProducts
                        tempArray?.append(contentsOf: searchResults.products ?? [])
                        self.fetchedProducts = tempArray
                    }
                }
            }catch {
                print("Error: \(error.localizedDescription)")
            }
        }.resume()
        
    }
    
}
