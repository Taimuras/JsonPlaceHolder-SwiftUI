//
//  CustomTabBarStyle.swift
//  ReSwiftUsage
//
//  Created by Timur on 24/2/23.
//

import SwiftUI
import TabBar

struct CustomTabBarStyle: TabBarStyle {
    
    public func tabBar(with geometry: GeometryProxy, itemsContainer: @escaping () -> AnyView) -> some View {
        itemsContainer()
            .background(Color.white)
            .cornerRadius(35.0)
            .frame(height: 70.0)
            .padding(.horizontal, 32.0)
            .padding(.bottom, geometry.safeAreaInsets.bottom)
            .shadow(color: Color(red: 0.173, green: 0.051, blue: 0.306, opacity: 0.1), radius: 18, x: 1, y: 16)
    }
    
}

