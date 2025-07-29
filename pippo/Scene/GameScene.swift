//
//  GameScene.swift
//  barto
//
//  Created by Pepo on 29/07/25.
//

import SpriteKit

class GameScene: SKScene {
    override func didMove(to view: SKView) {
        backgroundColor = .clear
        
        // PePS: instanciando a sprite sheet
        let spriteSheet = SKTexture(imageNamed: "pippo_spritesheet")
        
        // peps: mudar a renderização do spritesheet (se quiser serrilhado e tal)
        spriteSheet.filteringMode = .nearest
        
        
        //tamanho da sprite sheet inteira
        let spriteSheetWidth: CGFloat = 96
        let frameWidth: CGFloat = 24
        let frameHeight: CGFloat = 24

        var frames: [SKTexture] = []

        for i in 0..<3 {
            let x = CGFloat(i) * frameWidth / spriteSheetWidth
            let rect = CGRect(x: x, y: 0, width: frameWidth / spriteSheetWidth, height: 1.0)
            let frame = SKTexture(rect: rect, in: spriteSheet)
            frame.filteringMode = .nearest
            frames.append(frame)
        }

        let sprite = SKSpriteNode(texture: frames[0])
        sprite.position = CGPoint(x: size.width / 2, y: size.height / 2)
        sprite.setScale(6.0) // pixel art ficar visível
        addChild(sprite)

        let animation = SKAction.animate(with: frames, timePerFrame: 0.15)
        sprite.run(.repeatForever(animation))
    }
}
