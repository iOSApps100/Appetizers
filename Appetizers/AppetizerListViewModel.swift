//
//  AppetizerListViewModel.swift
//  Appetizers
//
//  Created by Vivek  Garg on 05/09/24.
//

import SwiftUI

final class AppetizerListViewModel: ObservableObject {
    @Published var appetizers: [Appetizer] = []
    
    func getAppetizers() {
        NetworkManager.shared.getAppetizer { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let appetizers):
                    // this should be on main thread because its swiftUI this data reflects in UI
                    self.appetizers = appetizers
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
