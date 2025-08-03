//
//  Question.swift
//  eggsy
//
//  Created by Pepo on 02/08/25.
//

import Foundation

struct ConsequenceRule {
    let key: String
    let text: String
    let imageName: String?
    let conditions: [(questionId: String, expectedAnswer: Bool)]
}

// Modelo da questão (você deve ter algo assim no seu código)
struct Question {
    let id: String
    let text: String
    let imageName: String
    let yesResponse: String
    let noResponse: String
    let yesImage: String?
    let noImage: String?
    let yesImageSize: CGSize?
    let noImageSize: CGSize?
}

