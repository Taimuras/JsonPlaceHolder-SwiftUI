//
//  AlertView.swift
//  ReSwiftUsage
//
//  Created by Timur on 24/2/23.
//

import SwiftUI

struct AlertsView: View {
    var text:String
    var isSuccess:Bool
    
    var body: some View {
        HStack(alignment: .center, spacing: 0){
            Text(text)
                .foregroundColor(Color.green)
                .font(.title)
            Spacer()
//            Image(isSuccess ? "successEmoji" : "failEmoji")
//                .resizable()
//                .frame(width: 44, height: 44)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.all, 10)
        .background(.white)
        .cornerRadius(8)
        .padding(.horizontal, 16)
        .shadow(color: Color.blue.opacity(0.19), radius: 40, x: 1, y: 2)

    }
}

struct AlertsView_Previews: PreviewProvider {
    static var previews: some View {
        AlertsView(text: "Hello", isSuccess: true)
    }
}
