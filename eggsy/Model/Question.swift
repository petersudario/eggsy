//
//  Question.swift
//  eggsy
//
//  Created by Pepo on 02/08/25.
//

import Foundation

struct Question {
    let id: String
    let text: String
    let imageName: String
    let yesResponse: String
    let noResponse: String

    var yesHasConsequence: Bool? = false
    var noHasConsequence: Bool? = false
    var consequenceKey: String? = nil
    var consequenceText: String? = nil

    var yesImage: String? = nil
    var noImage: String? = nil
    var yesConsequenceImage: String? = nil
    var noConsequenceImage: String? = nil

    var imageSize: CGSize? = nil
    var yesImageSize: CGSize? = nil
    var noImageSize: CGSize? = nil
    var yesConsequenceImageSize: CGSize? = nil
    var noConsequenceImageSize: CGSize? = nil
}



