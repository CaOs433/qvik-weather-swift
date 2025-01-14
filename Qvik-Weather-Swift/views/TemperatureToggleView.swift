//
//  TemperatureToggleView.swift
//  Qvik-Weather-Swift
//
//  Created by Oskari Saarinen on 7.1.2025.
//

import SwiftUI

public struct TemperatureToggleView: View {
    @Binding var temperatureUnit: Onecall.TemperatureUnit
    
    var isOn: Bool {
        self.temperatureUnit == .metric
    }
    
    var symbol: String {
        self.isOn
            ? UnitTemperature.celsius.symbol
            : UnitTemperature.fahrenheit.symbol
    }
    
    public var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    self.isOn
                        ? Color.toggleButton
                        : Color.gray.opacity(0.2)
                )
                .accessibilityIdentifier("toggleBackground")
            
            Circle()
                .fill(.white)
                .frame(width: 26, height: 26, alignment: .leading)
                .animation(.easeOut(duration: 0.5), value: self.temperatureUnit)
                .offset(x: self.isOn ? 16 : -16)
                .padding(.leading, 0)
                .accessibilityIdentifier("toggleCircle")
            
            Text(self.symbol)
                .frame(width: 63, alignment: .leading)
                .offset(x: 6)
                .font(.custom("Inter-Regular_SemiBold", size: 14))
                .foregroundStyle(.black)
                .accessibilityIdentifier(self.isOn ? "celsiusText" : "fahrenheitText")
            
        }
            .frame(width: 63, height: 30, alignment: .leading)
            .accessibilityIdentifier("temperatureToggleView")
            .onTapGesture {
                self.temperatureUnit.toggle()
            }
    }
    
}

#Preview {
    TemperatureToggleView(temperatureUnit: .constant(.metric))
}
