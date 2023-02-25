//
//  ButtonStyles.swift
//  ReSwiftUsage
//
//  Created by Timur on 24/2/23.
//

import Foundation
import SwiftUI

struct MainButton: ButtonStyle {
    var isActive: Bool = true
    var padding: CGFloat = 13
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .disabled(isActive)
            .foregroundColor(.white.opacity(configuration.isPressed ? 0.6 : 1))
            .font(.title)
            .frame(maxWidth: .infinity)
            .padding(.vertical, padding)
            .background(isActive ? Color.blue : Color.red)
            .cornerRadius(60)
    }
}

struct MainShortButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .font(.title)
            .padding(.all, 13)
            .background(.blue)
            .cornerRadius(60)
    }
}


struct SecondaryButton: ButtonStyle {
    var padding: CGFloat = 13
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.black.opacity(configuration.isPressed ? 0.6 : 1))
            .font(.title)
            .frame(maxWidth: .infinity)
            .padding(.vertical, padding)
//            .background(.white)
            .overlay(
                    RoundedRectangle(cornerRadius: 60)
                        .stroke(.black, lineWidth: 2)
                )
    }
}

struct QuestionButton: ButtonStyle {
    var isActive: Bool = true
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .disabled(isActive)
            .foregroundColor(.white.opacity(configuration.isPressed ? 0.6 : 1))
            .font(.title)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(isActive ? Color.black : Color.red)
            .cornerRadius(60)
    }
}

struct GenderButton: ButtonStyle {
    var isSelected: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(isSelected ? .white : Color.red)
            .font(.title)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(isSelected ? Color.black : Color.red)
            .cornerRadius(60)
            .overlay(
                    RoundedRectangle(cornerRadius: 60)
                        .stroke(Color.red, lineWidth: 2)
                )
    }
}

struct PaginationButton: ButtonStyle {
    var size:CGFloat
    var isSelected: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(isSelected ? .white : Color.accentColor)
            .font(.title)
            .frame(width: 45, height: 45, alignment: .center)
            .background(isSelected ? Color.accentColor : Color.red)
            .cornerRadius(8)
    }
}

struct DefaultButton: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.black.opacity(configuration.isPressed ? 0.6 : 1))
            .background(.clear)
    }
}


