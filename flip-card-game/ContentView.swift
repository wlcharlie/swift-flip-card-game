//
//  ContentView.swift
//  flip-card-game
//
//  Created by Charlie Chiou on 2023/5/28.
//

import SwiftUI




struct ContentView: View {
    var body: some View {
        NavigationView {
            HomeView()
        }.navigationTitle("Home")
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
