//
//  HomeView.swift
//  flip-card-game
//
//  Created by Charlie Chiou on 2023/6/2.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            VStack {
                Text("Memory Game").font(.largeTitle).bold()
                Text("Flip The Card, Match The Card")
            }
            Spacer()
            NavigationLink(destination: GameView()) {
                Text("Flip!")
                .padding()
                .background(Color(.systemIndigo))
                .foregroundColor(Color(.white))
                .cornerRadius(4)
            }
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
