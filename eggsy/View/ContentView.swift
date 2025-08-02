//
//  ContentView.swift
//  eggsy
//
//  Created by Pepo on 29/07/25.
//

import SwiftUI
import RouterKit

struct ContentView: View {
    
    var body: some View {

        RouterView<AppRoute>(rootView: .startscreen, showBackButton: false)

    }
    
}

enum AppRoute: Routable {
    case startscreen
    case cutscene
    case game
    
    var view: any View {
        switch self {
        case .startscreen: StartScreen()
        case .cutscene: Cutscene()
        case .game: Game()
        }
    }
}

