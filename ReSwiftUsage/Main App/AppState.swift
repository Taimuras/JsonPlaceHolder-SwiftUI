//
//  AppState.swift
//  ReSwiftUsage
//
//  Created by Timur on 24/2/23.
//

import Foundation

class AppState: ObservableObject{
    @Published var isPopUpShown: Bool = false
    @Published var isAlertShown: Bool = false
    
}
