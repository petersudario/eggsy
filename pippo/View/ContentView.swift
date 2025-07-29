//
//  ContentView.swift
//  barto
//
//  Created by Pepo on 29/07/25.
//

import SwiftUI
import SpriteKit

import SwiftUI

struct ContentView: View {
    var body: some View {
        TransparentSpriteView(scene: GameScene(size: CGSize(width: 128, height: 128)))
            .frame(width: 128, height: 128)
            .background(Color.clear)
            .ignoresSafeArea()
    }
}



#Preview {
    ContentView()
}
