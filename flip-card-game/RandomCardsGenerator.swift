//
//  File.swift
//  flip-card-game
//
//  Created by Charlie Chiou on 2023/5/28.
//

import Foundation


struct cardItem: Hashable, Identifiable {
    var value: Int
    var symbol: CardSymbol
    var id: UUID
    
    mutating func renewId () {
        id = UUID()
    }
}

struct RandomCardsGenerator {
    var cards: [cardItem] = []
    
    static func genRandomCard () -> cardItem {
        return cardItem(value: Int.random(in: 1...13), symbol: CardSymbol.allCases.randomElement()!, id: UUID() )
    }
    
    mutating func genCard () {
        let card: cardItem = RandomCardsGenerator.genRandomCard()
        var card2 = card
        card2.renewId()
        if(cards.contains{$0.value == card.value && $0.symbol == card.symbol}) {
            return genCard()
        }
        
        cards.append(card)
        cards.append(card2)
    }
}
