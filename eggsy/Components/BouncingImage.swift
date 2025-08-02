//
//  BouncingImage.swift
//  eggsy
//
//  Created by Pepo on 01/08/25.
//


import SwiftUI

struct BouncingImage: View {
    let imageName: String
    let size: CGSize

    @State private var bounce = false

    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: size.width, height: size.height)
            .offset(x: bounce ? -10 : 10)
            .animation(
                Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true),
                value: bounce
            )
            .onAppear {
                bounce = true
            }
    }
}
