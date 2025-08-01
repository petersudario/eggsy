//
//  ActionButton.swift
//  eggsy
//
//  Created by Pepo on 01/08/25.
//

import SwiftUI

struct ActionButton: View {
    var text: String
    var action: () -> Void = { }
    var body: some View {
        ZStack {
            Image("button_box")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 237, height: 109)

            Text(text)
                .font(.custom("Chalkboy", size: 68))
        }
        .contentShape(Rectangle())
        .onTapGesture {
            action()
        }
    }
}

