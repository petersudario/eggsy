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
    var noHasConsequence: Bool? = false
    var yesHasConsequence: Bool? = false
    var consequenceText: String?
    var consequenceKey: String? = nil
    var consequenceImageName: String? = nil
    var alternativeImageName: String? = nil
    var imageSize: CGSize? = nil
    var consequenceImageSize: CGSize? = nil
    var alternativeImageSize: CGSize? = nil

}


