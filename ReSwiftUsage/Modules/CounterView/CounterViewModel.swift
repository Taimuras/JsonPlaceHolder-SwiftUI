//
//  CounterViewModel.swift
//  ReSwiftUsage
//
//  Created by Timur on 24/2/23.
//

import Foundation

class CounterViewModel: ObservableObject{
    static let shared = CounterViewModel()
    
    
    @Published var count = 0
    
    func increment(){
        count += 1
    }
    
    func decrement(){
        count -= 1
    }
}
