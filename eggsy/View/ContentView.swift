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

enum EndingType {
    case good
    case bad
}

enum AppRoute: Routable {
    case startscreen
    case cutscene
    case game
    case ending(type: EndingType)

    var view: any View {
        switch self {
        case .startscreen:
            return AnyView(StartScreen())
        case .cutscene:
            return AnyView(Cutscene())
        case .game:
            return AnyView(Game())
        case .ending(let type):
            return AnyView(Ending(type: type))
        }
    }
}
