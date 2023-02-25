//
//  CustomTabItemStyle.swift
//  ReSwiftUsage
//
//  Created by Timur on 24/2/23.
//

import SwiftUI
import TabBar

struct CustomTabItemStyle: TabItemStyle {
    
    static let colors: [Color] = [
        Color(red: 0.125, green: 0.016, blue: 0.275),
        Color(red: 0.309, green: 0.148, blue: 0.395),
        Color(red: 0.663, green: 0.404, blue: 0.627)
    ]
    
    let selectedGradient = LinearGradient(colors: CustomTabItemStyle.colors, startPoint: .bottomLeading, endPoint: .topTrailing)
    
    public func tabItem(icon: String, title: String, isSelected: Bool) -> some View {
        VStack {
            ZStack {
                if isSelected {
                    Circle()
                        .fill(selectedGradient)
                        .frame(width: 28, height: 28)
                }
                Image(systemName: icon)
                    .foregroundColor(isSelected ? .white : Color(red: 0.416, green: 0.467, blue: 0.502))
                    .frame(width: 24, height: 24)
            }
            Text(title)
                .frame(height: 10)
        }
        .padding(.vertical, 8.0)
    }
    
}

