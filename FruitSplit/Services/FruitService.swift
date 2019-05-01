//
//  FruitService.swift
//  FruitSplit
//
//  Created by Chelsea Troy on 4/29/19.
//  Copyright © 2019 Chelsea Troy. All rights reserved.
//

import UIKit

class FruitService {
    var dataTask: URLSessionDataTask?
    
    private let urlString = "https://api.unsplash.com/search/photos?page=1&per_page=20&query="
    
    func search(for searchTerm: String, completion: @escaping ([Fruit]?, Error?) -> ()) {
        authenticate(completion: { accessKey, error in
            guard let accessKey = accessKey, error == nil else {
                print(error ?? "unknown error")
                return
            }
       
            guard let url = URL(string: self.urlString + searchTerm) else {
                print("invalid url: \(self.urlString + searchTerm)")
                return
            }
        
            var request = URLRequest(url: url)
            request.setValue("Client-ID \(accessKey)", forHTTPHeaderField: "Authorization")
        
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
                guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                    DispatchQueue.main.async { completion(nil, error) }
                    return
                }
            
                print("Status code: \(response.statusCode)")
                print(String(data: data, encoding: .utf8) ?? "unable to print data")
            
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let fruitResult = try decoder.decode(FruitResult.self, from: data)
                    DispatchQueue.main.async { completion(fruitResult.results, nil) }
                } catch (let error) {
                    DispatchQueue.main.async { completion(nil, error) }
                }
            }
            task.resume()
        })
    }
    
    func authenticate(completion: @escaping (String?, Error?) -> ()) {
        guard let url = URL(string: "http://www.mocky.io/v2/5cc7bc47320000fc0db952d4") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let _ = response as? HTTPURLResponse, error == nil else {
                DispatchQueue.main.async { completion(nil, error) }
                return
            }
                        do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let keyResult = try decoder.decode(Authentication.self, from: data)
                DispatchQueue.main.async { completion(keyResult.accessKey, nil) }
            } catch (let error) {
                DispatchQueue.main.async { completion(nil, error) }
            }
        }
        task.resume()
    }

}


