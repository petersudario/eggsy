//
//  CutsceneStep.swift
//  eggsy
//
//  Created by Pepo on 01/08/25.
//

enum CutsceneStep {
    case showText(String)
    case changeImage(String)
    case typewriter(String)
    case playSound(String)
    case waitForButton(title: String)
}
