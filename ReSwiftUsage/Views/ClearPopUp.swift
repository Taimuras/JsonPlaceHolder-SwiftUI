//
//  ClearPopUp.swift
//  ReSwiftUsage
//
//  Created by Timur on 24/2/23.
//

import SwiftUI

struct ClearPopup: View {
    var text:String
    var image:String
    var clearAction:() -> Void
    @Binding var showPopup: Bool
    
    init(text:String, image:String, showPopup: Binding<Bool>, action: @escaping () -> Void) {
        self.text = text
        self.image = image
        self._showPopup = showPopup
        self.clearAction = action
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 24){
            Image(image)
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .colorMultiply(Color.black)
            
            Text(text)
                .font(.title)
                .foregroundColor(Color.black)
                .multilineTextAlignment(.center)
            HStack{
                Button("Отменить", action: {
                    showPopup.toggle()
                })
                .buttonStyle(MainButton())
                .frame(maxWidth: .infinity,alignment: .center)
                Button("Очистить", action: {
                   clearAction()
                   showPopup.toggle()
                })
                .buttonStyle(SecondaryButton())
                .frame(maxWidth: .infinity,alignment: .center)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 24)
        .frame(maxWidth: .infinity,alignment: .center)
        .background(.white)
        .cornerRadius(24)
        .padding(.horizontal, 16)
    }
}

