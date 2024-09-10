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
        ZStack { // for showing indicator view on top of everything.
            NavigationView {
                List(viewModel.appetizers) { appetizer in
                   AppetizerListCell(appetizer: appetizer)
                        
                }.listStyle(GroupedListStyle())
                
                
                .navigationTitle("🍟 Appetizers")
            }
            .onAppear {
                viewModel.getAppetizers()
            }
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
}

#Preview {
    AppetizerListView()
}
