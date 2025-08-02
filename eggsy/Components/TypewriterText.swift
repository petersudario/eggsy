//
//  TypewriterText.swift
//  eggsy
//
//  Created by Pepo on 01/08/25.
//

import SwiftUI

struct TypewriterText: View {
    let fullText: String
    let speed: Double
    let fontName: String
    let fontSize: CGFloat
    var onFinished: (() -> Void)? = nil

    @State private var displayedText: String = ""
    @State private var currentIndex: Int = 0

    var body: some View {
        Text(displayedText)
            .font(.custom(fontName, size: fontSize))
            .onAppear {
                displayedText = ""
                currentIndex = 0
                typeNextLetter()
            }
    }

    private func typeNextLetter() {
        guard currentIndex < fullText.count else {
            onFinished?()
            return
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + speed) {
            let index = fullText.index(fullText.startIndex, offsetBy: currentIndex)
            displayedText.append(fullText[index])
            currentIndex += 1
            typeNextLetter()
        }
    }
}

