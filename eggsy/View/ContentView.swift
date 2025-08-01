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

        RouterView<AppRoute>(rootView: .startscreen)

    }
    
}

enum AppRoute: Routable {
    case startscreen
    case game
    
    var view: any View {
        switch self {
        case .startscreen: StartScreen().hideBackButton()
        case .game: Game().hideBackButton()
        }
    }
    
}


struct HideBackButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
    }
}

extension View {
    func hideBackButton() -> some View {
        self.modifier(HideBackButton())
    }
}
