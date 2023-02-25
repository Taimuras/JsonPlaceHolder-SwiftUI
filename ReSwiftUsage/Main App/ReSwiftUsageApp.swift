//
//  ReSwiftUsageApp.swift
//  ReSwiftUsage
//
//  Created by Timur on 24/2/23.
//

import SwiftUI
import PopupView

@main
struct ReSwiftUsageApp: App {
    @StateObject var appState: AppState = AppState()
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .popup(isPresented: $appState.isPopUpShown, view: {
                    AlertsView(text: "1 товар удален", isSuccess: false)
                }, customize: {
                    $0.type(.floater(verticalPadding: 20, useSafeAreaInset: true))
                        .position(.top)
                        .dragToDismiss(true)
                        .autohideIn(1)
                })
                .popup(isPresented: $appState.isAlertShown) {
                    ClearPopup(text: "Вы правда хотите\nочистить избранное?", image: "person", showPopup:  $appState.isAlertShown){
                        print("YES")
                    }
                } customize: {
                    $0.type(.default)
                        .closeOnTap(false)
                        .backgroundColor(Color.black.opacity(0.3))
                }
                .environmentObject(appState)
        }
    }
}
