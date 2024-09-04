//
//  AppetizerListView.swift
//  Appetizers
//
//  Created by Vikram kumar on 03/09/24.
//

import SwiftUI

struct AppetizerListView: View {
    var body: some View {
        NavigationView {
            List(MockData.appetizers) { appetizer in
               AppetizerListCell(appetizer: appetizer)
                
            }
            
                .navigationTitle("🍟 Appetizers")
        }
    }
}

#Preview {
    AppetizerListView()
}
