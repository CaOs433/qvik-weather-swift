//
//  ContentView.swift
//  Qvik-Weather-Swift
//
//  Created by Oskari Saarinen on 5.1.2025.
//

import SwiftUI

public struct ContentView: View {
    init() {
        self.configureNavigationBar()
    }
    
    public var body: some View {
        NavigationStack {
            EditAPIKeyView()
        }
            .toolbar(.visible)
            .ignoresSafeArea()
            .tint(Color.mainText)
            .edgesIgnoringSafeArea(.all)
    }
    
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.black.withAlphaComponent(0.6)

        let attrs: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "Inter-Regular_Bold", size: 12)!
        ]
        
        appearance.largeTitleTextAttributes = attrs
        appearance.titleTextAttributes = attrs
        appearance.buttonAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor(named: "Main-Text-Color") ?? UIColor.white,
            .font: UIFont(name: "Inter-Regular_Bold", size: 22)!
        ]
        
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
    }
    
}

#if DEBUG
#Preview {
    ContentView()
}
#endif
