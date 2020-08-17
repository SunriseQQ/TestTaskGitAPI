//
//  HTTPManager.swift
//  NaPopravkuTestTask(API GIT)
//
//  Created by Sunrise on 16.08.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import Foundation
import UIKit

class HTTPManager {
    static let shared: HTTPManager = HTTPManager()

    enum HTTPError: Error {
        case invalidURL
        case invalidResponse(Data?, URLResponse?)
    }
    
    public func get(urlString: String, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completionBlock(.failure(HTTPError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completionBlock(.failure(error!))
                return
            }

            guard
                let responseData = data,
                let httpResponse = response as? HTTPURLResponse,
                200 ..< 300 ~= httpResponse.statusCode else {
                    completionBlock(.failure(HTTPError.invalidResponse(data, response)))
                    return
            }

            completionBlock(.success(responseData))
        }
        task.resume()
    }
    
    public func downloadImage(from url: String) -> UIImage {
        let url = URL(string: url)
        guard let data = try? Data(contentsOf: url!) else {return defaultImage} //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        return UIImage(data: data) ?? defaultImage
       
    }
}
