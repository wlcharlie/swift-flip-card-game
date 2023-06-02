//
//  GameView.swift
//  flip-card-game
//
//  Created by Charlie Chiou on 2023/6/2.
//

import SwiftUI

extension Array {
    subscript(safe range: Range<Index>) -> ArraySlice<Element> {
        return self[Swift.min(range.startIndex, self.endIndex)..<Swift.min(range.endIndex, self.endIndex)]
    }
    subscript(safeAt index: Int) -> Element? {
        guard self.count > index && index >= 0 else {
            return nil
        }
        return self[index]
    }
}


let matchCardValue = { (pairValue:String?, cardItem: cardItem) -> Bool in
    if let value = pairValue {
        let cardItemValue = cardValueToKey(cardItem)
        return pairValue! == cardItemValue
    } else {
        return false
    }
}

let cardValueToKey = { (cardItem: cardItem) -> String in
    "\(cardItem.value)\(cardItem.symbol.rawValue).\(cardItem.id)"
}




struct GameView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showPrompt = false
    @StateObject var cardsData = CardsData()
    

    func onTapCard (_ key: String) {
        let index = cardsData.pairings.firstIndex(of: key)
        if let index {
            cardsData.pairings.remove(at: index)
            return
        }
        cardsData.pairings.append(key)
    }

    
    
    var body: some View {
        VStack{
            HStack {
                VStack {
                    ForEach(0...(cardsData.cards.count / 4), id: \.self) { rowIndex in
                        HStack {
                            ForEach(
                                cardsData.cards[safe: (0 + (rowIndex * 4))..<(4 + (rowIndex * 4))], id: \.id)
                            { item in
                                let _ = print(cardsData.pairings)
                                Card(id: item.id,value: item.value, symbol: item.symbol, isFlip: matchCardValue(cardsData.pairings[safeAt: 0], item) || matchCardValue(cardsData.pairings[safeAt: 1], item), isPair: cardsData.matched.contains(cardValueToKey(item))
                                )
                                .padding(-10)
                                .onTapGesture {
                                    if cardsData.pairings.count == 2 { return }
                                    onTapCard("\(item.value)\(item.symbol.rawValue).\(item.id)")
                                }
                            }
                        }
                    }
                }
            }
            .frame( minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: 350)
            .background(Color(red:0.9,green:0.9,blue:0.9))
        }.alert(isPresented: Binding<Bool>(
            get: { showPrompt || cardsData.isAllMatched },
            set: { _ in }
        )) {
            if cardsData.isAllMatched {
                return Alert(
                    title: Text("Congratulation"),
                    message: Text("What a memory!"),
                    dismissButton: .destructive(Text("YAAA!")) {
                        presentationMode.wrappedValue.dismiss()
                    }
                )
            } else {
                return Alert(
                    title: Text("Confirmation"),
                    message: Text("Are you sure you want to leave?"),
                    primaryButton: .cancel(),
                    secondaryButton: .destructive(Text("Leave")) {
                        presentationMode.wrappedValue.dismiss()
                    }
                )
            }

        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .onDisappear {
            if presentationMode.wrappedValue.isPresented {
                showPrompt = true
            }
        }
    }
    
    private var backButton: some View {
        Button(action: {
            if presentationMode.wrappedValue.isPresented {
                showPrompt = true
            } else {
                presentationMode.wrappedValue.dismiss()
            }
        }) {
            Image(systemName: "chevron.left")
                .imageScale(.large)
                .padding()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
