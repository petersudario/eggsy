//
//  ActionButton.swift
//  eggsy
//
//  Created by Pepo on 01/08/25.
//

import SwiftUI

struct ActionButton: View {
    var text: String
    var width: CGFloat = 237
    var height: CGFloat = 198
    
    var action: () -> Void = { }
    var body: some View {
        ZStack {
            Image("button_box")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)

            Text(text)
                .font(.custom("Chalkboy", size: 68))
        }
        .contentShape(Rectangle())
        .onTapGesture {
            action()
        }
    }
}

