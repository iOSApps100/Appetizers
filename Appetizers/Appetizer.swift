//
//  Appetizer.swift
//  Appetizers
//
//  Created by Vikram Kumar on 04/09/24.
//

import Foundation

struct AppetizerResponse: Decodable {
    let request: [Appetizer]
}

struct Appetizer: Decodable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let price: Double
    let calories: Int
    let imageURL: String
    let protein: Int
    let carbs: Int
}

struct MockData {
    
    static let sampleAppetizer = Appetizer(id: 0001, name: "Test Appetizer", description: "This is test appetizer you can write long test here.", price: 9.99, calories: 99, imageURL: "", protein: 99, carbs: 99)
    
    static let appetizers = [sampleAppetizer, sampleAppetizer, sampleAppetizer, sampleAppetizer]
    
}

