//
//  NetworkManager.swift
//  Appetizers
//
//  Created by Vikram Kumar on 04/09/24.
//

import UIKit

//// final means other can not inherit it. Final will be for class types not value types.
final class NetworkManager {
    
    static let shared = NetworkManager()
    /// To store images in cache, NSCache<key,value>.
    private let cache = NSCache<NSString, UIImage>()
    
    static let baseURL = "https://seanallen-course-backend.herokuapp.com/swiftui-fundamentals/"
    private let appetizerURL = baseURL + "appetizers"
    
    private init() {}
    
    func getAppetizer(completion: @escaping (Result<[Appetizer], APError>) -> Void) {
        guard let url = URL(string: appetizerURL) else {
            completion(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(AppetizerResponse.self, from: data)
                completion(.success(decodedResponse.request))
                
            } catch {
                completion(.failure(.invalidData))
            }
            
        }.resume()
    }
    
    func downloadImage(fromURLString urlString: String, completion: @escaping (UIImage?) -> Void) {
        
        /// impose check of cache image before downloading images from network image.
        let cacheKey = NSString(string: urlString)
        
        //finding image for that key, key here we use is url of that image
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            /// we downloaded our image now set it cache first.
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }.resume()
    }
    
    
    
}
