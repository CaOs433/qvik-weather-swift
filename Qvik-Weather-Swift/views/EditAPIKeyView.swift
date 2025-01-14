//
//  SaveAPIKeyView.swift
//  Qvik-Weather-Swift
//
//  Created by Oskari Saarinen on 12.1.2025.
//

import SwiftUI

public struct EditAPIKeyView: View {
    @State private var apiKey: String
    @State private var apiKeySaved: Bool
    
    var partiallyHiddenAPIKey: String {
        guard self.apiKey.count > 14 else {
            return self.apiKey
        }
        
        let prefix = self.apiKey.prefix(5)
        let suffix = self.apiKey.suffix(5)
        let hiddenMiddle = String(repeating: "*", count: 5)
        
        return "\(prefix)\(hiddenMiddle)\(suffix)"
    }
    
    init() {
        let keyFromKeychain = getApiKeyFromKeychain(keyName: OpenWeatherMapAPI.apiKeyKeyInKeychain)
        
        self.apiKey = keyFromKeychain ?? ""
        self.apiKeySaved = keyFromKeychain != nil
    }
    
    public var body: some View {
        VStack {
            Spacer()
            
            Text("Enter API Key")
                .font(.custom("Inter-Regular_Bold", size: 28))
                .foregroundStyle(Color.mainText)
                .padding(10)
            
            EditAPIKeyTextFieldView(apiKey: self.$apiKey)
                .onChange(of: self.apiKey) {
                    self.apiKeySaved = false
                }
            
            Text(self.partiallyHiddenAPIKey)
                .font(.custom("Inter-Regular_Light", size: 20))
                .foregroundStyle(Color.mainText)
                .shadow(radius: 2, x: -2, y: -2)
                .padding(10)
            
            Divider()
                .padding(.vertical, 10)
            
            if self.apiKeySaved {
                NavigationLink(destination: WeatherView(), label: {
                    Text("Show Weather")
                        .foregroundStyle(Color.mainText)
                        .font(.custom("Inter-Regular_Bold", size: 20))
                        .padding(12)
                        .background(Color.blue.opacity(0.7))
                        .cornerRadius(20)
                })
            } else {
                Button(action: self.saveApiKey) {
                    Text("Save Key")
                        .foregroundStyle(Color.mainText)
                }
                    .padding(12)
                    .background(Color.green.opacity(0.7))
                    .cornerRadius(15)
                    .font(.custom("Inter-Regular_Bold", size: 20))
            }
            
            Spacer()
        }
            .padding()
            .background(alignment: .center) {
                editAPIKeyBackgroundGradientView
            }
    }
    
    private func saveApiKey() {
        print("Saving API Key: \(self.apiKey)")
        
        saveApiKeyToKeychain(
            apiKey: self.apiKey,
            keyName: OpenWeatherMapAPI.apiKeyKeyInKeychain
        )
        
        self.apiKeySaved = true
    }
    
}

private struct EditAPIKeyTextFieldView: View {
    @Binding var apiKey: String
    
    var body: some View {
        HStack {
            Image("assets_other_api")
                .frame(width: 24, height: 24)
                .padding(.leading, 10)
            
            SecureField("API Key", text: self.$apiKey)
                .padding(.vertical, 10)
            
            if self.apiKey.count > 0 {
                Image("assets_other_close")
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 10)
                    .foregroundStyle(Color.textFieldText)
                    .onTapGesture {
                        withAnimation {
                            self.apiKey = ""
                        }
                    }
            }
        }
            .background(Color.white.opacity(0.8))
            .cornerRadius(20)
            .font(.custom("Inter-Regular", size: 16))
            .foregroundStyle(Color.textFieldText)
    }
    
}

#Preview {
    EditAPIKeyView()
}
