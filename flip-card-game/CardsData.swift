//
//  CardsData.swift
//  flip-card-game
//
//  Created by Charlie Chiou on 2023/6/2.
//

import Foundation
import Combine

let cardsData = { (totalCount: Int) -> [cardItem] in
    var randomCards = RandomCardsGenerator()
    while (randomCards.cards.count != totalCount) {
        randomCards.genCard()
    }
    return randomCards.cards
}

class CardsData: ObservableObject {
    @Published var cards = cardsData(8).shuffled()
    @Published var pairings: [String] = [] {
        didSet {
            if(pairings.count == 2) {
                let firstCardValue = pairings[0].split(separator: ".")[0]
                let secondCardValue = pairings[1].split(separator: ".")[0]
                
                if (firstCardValue == secondCardValue) {
                    matched.append(pairings[0])
                    matched.append(pairings[1])
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
                    self.pairings = []
                }
            }
        }
    }
    @Published var matched: [String] = [] {
        didSet {
            if matched.count == 8 {
                isAllMatched = true
            }
        }
    }
    @Published var isAllMatched : Bool = false
}
