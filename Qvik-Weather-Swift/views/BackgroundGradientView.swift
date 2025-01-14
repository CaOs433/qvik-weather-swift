//
//  BackgroundGradientView.swift
//  Qvik-Weather-Swift
//
//  Created by Oskari Saarinen on 5.1.2025.
//

import SwiftUI

public struct BackgroundGradientView: View {
    var gradientColors: [Color]
    
    public var body: some View {
        LinearGradient(
            gradient:
                Gradient(
                    colors: gradientColors
                ),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
            .ignoresSafeArea()
    }
    
}

public let weatherBackgroundGradientView = BackgroundGradientView(
    gradientColors: [
        Color.bgBrown,
        Color.bgBlue
    ]
)

public let editAPIKeyBackgroundGradientView = BackgroundGradientView(
    gradientColors: [
        Color.bgBlue,
        Color.bgBrown,
        Color.bgBlue
    ]
)

#Preview("Weather Background") {
    weatherBackgroundGradientView
}

#Preview("Edit API Key Background") {
    editAPIKeyBackgroundGradientView
}
