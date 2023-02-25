//
//  CounterView.swift
//  ReSwiftUsage
//
//  Created by Timur on 24/2/23.
//

import SwiftUI
import PopupView

struct CounterView: View {
    @StateObject var viewModel = CounterViewModel.shared
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        GeometryReader { (geometry) in
            VStack(alignment: .center, spacing: 20){
                Spacer()
                Text("Counter: \(viewModel.count)")
                    .font(.largeTitle)
                    .fontWeight(.black)
                Button {
                    viewModel.increment()
                } label: {
                    Text("+1")
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(12)
                        .padding([.leading, .trailing], 16)
                }
                Button {
                    viewModel.decrement()
                } label: {
                    Text("-1")
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .background(Color.blue)
                        .cornerRadius(14)
                        .foregroundColor(Color.white)
                        .padding([.leading, .trailing], 16)
                }
                
                Button {
                    appState.isPopUpShown = true
                } label: {
                    Text("Show PopUp")
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .background(Color.yellow)
                        .cornerRadius(14)
                        .foregroundColor(Color.white)
                        .padding([.leading, .trailing], 16)
                }
                
                Button {
                    appState.isAlertShown = true
                } label: {
                    Text("Show Alert")
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .background(Color.yellow)
                        .cornerRadius(14)
                        .foregroundColor(Color.white)
                        .padding([.leading, .trailing], 16)
                }
                Spacer()
            }
            .background(Color.green)
        }
        .ignoresSafeArea()
        
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView()
    }
}
