//
//  ContentView.swift
//  barto
//
//  Created by Pepo on 29/07/25.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    var scene: SKScene {
        let scene = GameScene(size: CGSize(width: 128, height: 128))
        scene.scaleMode = .resizeFill
        return scene
    }

    var body: some View {
        SpriteView(scene: scene)
            .frame(width: 128, height: 128)
            .background(.clear) 
            .ignoresSafeArea()
    }
}


#Preview {
    ContentView()
}
