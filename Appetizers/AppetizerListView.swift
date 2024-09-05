//
//  AppetizerListView.swift
//  Appetizers
//
//  Created by Vikram kumar on 03/09/24.
//

import SwiftUI

struct AppetizerListView: View {
    //Remember when initilizing your view model use @stateobject and if youre passing the view model form previous view use @observableobject
    @StateObject var viewModel = AppetizerListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.appetizers) { appetizer in
               AppetizerListCell(appetizer: appetizer)
            }
            .navigationTitle("🍟 Appetizers")
        }
        .onAppear {
            viewModel.getAppetizers()
        }
    }
    
   
}

#Preview {
    AppetizerListView()
}
