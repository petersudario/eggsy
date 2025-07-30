//
//  AnimatedBackgroundView.swift
//  pippo
//
//  Created by Pepo on 29/07/25.
//


import SwiftUI

struct AnimatedBackgroundView: View {
    let images = ["animated_background_1", "animated_background_2", "animated_background_3"]
    
    @State private var currentIndex = 0

    var body: some View {
        ZStack {
            Image(images[currentIndex])
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .transition(.opacity)
                .id(currentIndex)
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { _ in
                withAnimation() {
                    currentIndex = (currentIndex + 1) % images.count
                }
            }
        }
    }
}
