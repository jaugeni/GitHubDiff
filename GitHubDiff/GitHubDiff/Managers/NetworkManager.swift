//
//  NetworkManager.swift
//  GitHubDiff
//
//  Created by YAUHENI IVANIUK on 2/17/21.
//

import Foundation

class NetworkManager {
    
    private var url: String
    
    init(url: String) {
        self.url = url
    }
    
    func get<T: Decodable>(result: T.Type, completed: @escaping (Result<T, GitErrors>) -> Void) {
        
        guard let url = URL(string: url) else {
            completed(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completed(.failure(.serverError))
                print("Debug ERROR: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.ivalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decoded = try decoder.decode(T.self, from: data)
                completed(.success(decoded))
            } catch {
                completed(.failure(.failtoDecodeData))
            }
        }
        
        task.resume()
    }
}
