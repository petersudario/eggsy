//
//  TransparentSpriteView.swift
//  eggsy
//
//  Created by Pepo on 29/07/25.
//


// Essa desgraça de sprite só ficou transparente se fosse assim

import SwiftUI
import SpriteKit

struct TransparentSpriteView: UIViewRepresentable {
    let scene: SKScene

    func makeUIView(context: Context) -> SKView {
        let view = SKView()
        view.allowsTransparency = true
        view.backgroundColor = .clear
        view.presentScene(scene)
        return view
    }

    func updateUIView(_ uiView: SKView, context: Context) {
        // Não precisa atualizar a cena
    }
    
    
    
}
