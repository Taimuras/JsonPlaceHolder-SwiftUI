//
//  TabBarView.swift
//  ReSwiftUsage
//
//  Created by Timur on 24/2/23.
//

import SwiftUI
import TabBar
import Combine

struct TabBarView: View {
    @State private var selection: TabBarItems = .first
    
    var body: some View {
        NavigationView{
            TabBar(selection: $selection) {
                CurrencyView()
                    .tabItem(for: TabBarItems.first)
                CounterView()
                    .tabItem(for: TabBarItems.second)
                IMDBView(title: "IMDB")
                    .tabItem(for: TabBarItems.third)
            }
            .tabBar(style: CustomTabBarStyle())
            .tabItem(style: CustomTabItemStyle())
        }
        
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

