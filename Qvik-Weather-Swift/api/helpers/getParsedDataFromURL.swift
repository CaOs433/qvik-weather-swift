//
//  getParsedDataFromURL.swift
//  Qvik-Weather-Swift
//
//  Created by Oskari Saarinen on 6.1.2025.
//

import Foundation

/// Fetch and parse data from the given URL. Throw an error in case of failure.
/// - Parameter urlString: Fetching URL as a String.
/// - Throws: An error if the URL is invalid, the network request fails, the data is missing or cannot be decoded, or any other unexpected error occurs.
/// - Returns: A decoded object of type `T` if the operation is successful.
public func getParsedDataFromURL<T: Codable>(from urlString: String) throws -> T {
    let semaphore = DispatchSemaphore(value: 0)
    var result: Result<T, Error>?
    
    fetchDataFromUrl(from: urlString) { fetchResult in
        result = fetchResult
        semaphore.signal()
    }
    
    semaphore.wait()
    
    switch result {
    case .success(let response):
        return response
    case .failure(let error):
        throw error
    case .none:
        throw "Unknown error"
    }
    
}
