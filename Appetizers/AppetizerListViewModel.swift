//
//  AppetizerListViewModel.swift
//  Appetizers
//
//  Created by Vivek  Garg on 05/09/24.
//

import SwiftUI

final class AppetizerListViewModel: ObservableObject {
    @Published var appetizers: [Appetizer] = []
    // whenever alertItem changes we show the changed message
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    
    func getAppetizers() {
        isLoading = true
        NetworkManager.shared.getAppetizer {  result in
            
            DispatchQueue.main.async { [self] in
                isLoading = false
                switch result {
                    
                case .success(let appetizers):
                    // this should be on main thread because its swiftUI this data reflects in UI
                    self.appetizers = appetizers
                case .failure(let error):
                    switch error {
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                        
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                        
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                        
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
}
