//
//  GameScene.swift
//  eggsy
//
//  Created by Pepo on 29/07/25.
//

import SpriteKit

class GameScene: SKScene {
    override func didMove(to view: SKView) {
        backgroundColor = .clear

        // Carrega a imagem como UIImage para uso com cropping em pontos
        guard let image = UIImage(named: "pippo_spritesheet") else {
            print("Erro: imagem 'pippo_spritesheet' não encontrada")
            return
        }

        // Cria a textura base da sprite sheet
        let spriteSheet = SKTexture(imageNamed: "pippo_spritesheet")
        spriteSheet.filteringMode = .nearest

        let frameWidth: CGFloat = 24
        let frameHeight: CGFloat = 24
        let sheetWidth: CGFloat = 96
        let sheetHeight: CGFloat = 24

        var frames: [SKTexture] = []

        for i in 0..<3 {
            // Calcular valores normalizados
            let x = CGFloat(i) * frameWidth / sheetWidth
            // Y precisa ser invertido, pois a origem do SKTexture é no canto inferior esquerdo
            let y = 1.0 - (frameHeight / sheetHeight)
            let w = frameWidth / sheetWidth
            let h = frameHeight / sheetHeight
            
            let rect = CGRect(x: x, y: y, width: w, height: h)
            
            let frame = SKTexture(rect: rect, in: spriteSheet)
            frame.filteringMode = .nearest
            frames.append(frame)
        }

        // Cria o sprite com o primeiro frame
        let sprite = SKSpriteNode(texture: frames[0])
        sprite.position = CGPoint(x: size.width / 2, y: size.height / 2)
        sprite.setScale(5.0) // Escala para pixel art
        addChild(sprite)

        // Animação em loop
        let animation = SKAction.animate(with: frames, timePerFrame: 0.15)
        sprite.run(.repeatForever(animation))
    }
}
