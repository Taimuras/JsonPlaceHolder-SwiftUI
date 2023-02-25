//
//  TabBarItems.swift
//  ReSwiftUsage
//
//  Created by Timur on 24/2/23.
//

import Foundation
import TabBar

enum TabBarItems: Int, Tabbable {
    case first = 0
    case second
    case third
    
    var icon: String {
        switch self {
            case .first: return "house"
            case .second: return "magnifyingglass"
            case .third: return "person"
        }
    }
    
    var title: String {
        switch self {
            case .first: return "First"
            case .second: return "Second"
            case .third: return "Third"
        }
    }
}
