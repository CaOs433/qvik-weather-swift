//
//  fetchDataFromUrl.swift
//  Qvik-Weather-Swift
//
//  Created by Oskari Saarinen on 6.1.2025.
//

import Foundation

/// Fetch data from the given URL and try to parse it
/// - Parameters:
///   - urlString: Fetching URL as a String
///   - completion: Results handler for the received data
public func fetchDataFromUrl<T: Codable>(
    from urlString: String,
    completion: @escaping (Result<T, Error>) -> Void
) {
    guard let url = URL(string: urlString) else {
        completion(.failure("Invalid URL"))
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let data = data else {
            completion(.failure("No data received"))
            return
        }
        
        let decodingError: any Error
        do {
            let parsedResponse = try JSONDecoder().decode(T.self, from: data)
            completion(.success(parsedResponse))
            return
            
        } catch let error as DecodingError {
            decodingError = error
            if let parsedErrorResponse = try? JSONDecoder().decode(OpenWeatherMapAPI.APIErrorResponse.self, from: data) {
                print("Server returned error: \(parsedErrorResponse)")
            }
            
        } catch {
            decodingError = error
            
        }
        
        completion(.failure(decodingError))
    }
    
    task.resume()
    
}
