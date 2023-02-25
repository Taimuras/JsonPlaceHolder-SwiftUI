//
//  CurrencyView.swift
//  ReSwiftUsage
//
//  Created by Timur on 24/2/23.
//

import SwiftUI

struct CurrencyView: View {
    @StateObject var counter = CounterViewModel.shared
    
    
    var body: some View {
        Text("Currency View: \(counter.count)")
    }
}

struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyView()
    }
}
