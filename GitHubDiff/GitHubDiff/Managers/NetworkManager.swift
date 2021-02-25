//
//  NetworkManager.swift
//  GitHubDiff
//
//  Created by YAUHENI IVANIUK on 2/17/21.
//

import Foundation

class NetworkManager {
    
    static var share = NetworkManager()
    
    var url: String?
    
    private init() { }
    
    func get<T: Decodable>(result: T.Type, completed: @escaping (Result<T, GitErrors>) -> Void) {
        
        guard let urlString = url, let url = URL(string: urlString) else {
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
            completed(self.decode(from: data))
        }
        
        task.resume()
    }
    
    private func decode<T: Decodable>(from data: Data) -> (Result<T, GitErrors>) {
        
        if let str = String(decoding: data, as: UTF8.self) as? T {
            return .success(str)
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decoded = try decoder.decode(T.self, from: data)
            return .success(decoded)
        } catch {
            return .failure(.failtoDecodeData)
        }
    }
}
