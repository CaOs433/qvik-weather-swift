//
//  getApiKeyFromKeychain.swift
//  Qvik-Weather-Swift
//
//  Created by Oskari Saarinen on 6.1.2025.
//

import Foundation

/// Get the saved API key from Keychain.
/// - Parameter keyName: The key that holds value for the API key in Keychain.
/// - Returns: API key or nil in case of failure.
public func getApiKeyFromKeychain(keyName: String) -> String? {
    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrService as String: keyName,
        kSecReturnData as String: kCFBooleanTrue!,
        kSecMatchLimit as String: kSecMatchLimitOne
    ]
    
    var result: AnyObject?
    let status = SecItemCopyMatching(query as CFDictionary, &result)
    
    if status == errSecSuccess, let data = result as? Data {
        return String(data: data, encoding: .utf8)
    } else {
        print("Error retrieving API key from keychain: \(status.description)")
    }
    
    return nil
    
}

/// Save API key into the Keychain with the given key.
/// - Parameters:
///   - apiKey: API key to be saved into the Keychain.
///   - keyName: Key name for the API key in the Keychain.
public func saveApiKeyToKeychain(apiKey: String, keyName: String) {
    let data = apiKey.data(using: .utf8)!
    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrService as String: keyName,
        kSecValueData as String: data
    ]
    
    SecItemDelete(query as CFDictionary)
    let status = SecItemAdd(query as CFDictionary, nil)
    if status != errSecSuccess {
        print("Error saving API key: \(status)")
    }
    
}
