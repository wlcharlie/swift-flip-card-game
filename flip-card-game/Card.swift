//
//  Card.swift
//  flip-card-game
//
//  Created by Charlie Chiou on 2023/5/28.
//

import SwiftUI

enum CardSymbol: String, CaseIterable, Equatable {
    case heart = "card-symbol-heart"
    case diamond = "card-symbol-diamond"
    case club = "card-symbol-club"
    case spade = "card-symbol-spade"
}

let displayValues = ["A", "2", "3","4","5","6","7","8","9","10","J","Q","K"]

struct Card: View,Identifiable {
    var id: UUID
    var value: Int = 1
    var displayValue: String {
        return displayValues[value - 1]
    }
    var symbol: CardSymbol = CardSymbol.diamond
    var color: Color {
        switch (symbol) {
        case .heart:
            return .red
        case .diamond:
            return .red
        case .club:
            return .black
        case .spade:
            return .black
        }
    }

    var isFlip: Bool
    var isPair: Bool
    
    
    var body: some View {
        VStack {
            if (isFlip || isPair) {
                ZStack{
                    Text(displayValue).font(.system(size: 32)).fontWeight(.bold).foregroundColor(color).position(x: 20, y: 25)
                    Image(symbol.rawValue).resizable().aspectRatio(contentMode: .fit)
                        .frame(width: 55, height: 55)
                        .foregroundColor(color)
                        .position(x: 45, y: 75)
                        
                }
            } else {
                Image("card-back").resizable().aspectRatio(contentMode: .fit)
            }
    
        }.frame(width: 70, height: 100)
            .background(.white)
            .cornerRadius(4)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(.black.opacity(0.25), lineWidth: 1)
            )
            .padding()
            .clipped()
            .shadow(radius: 4, x:4, y:4)
            .opacity(isPair ? 0.5 : 1)
            .animation(.easeInOut, value: isPair)
            
    }
}



struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card(id: UUID(), value: 1, symbol: .heart, isFlip: false, isPair: false)
    }
}
