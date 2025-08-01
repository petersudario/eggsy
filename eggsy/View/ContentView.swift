//
//  ContentView.swift
//  eggsy
//
//  Created by Pepo on 29/07/25.
//

import SwiftUI
import SpriteKit

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            AnimatedBackgroundView()
            
            VStack (spacing: 200){
                Image("logo")
                    .resizable()
                    .frame(width: 270, height: 140)
                    .aspectRatio(contentMode: .fit)
                
                Image("start_button")
                    .resizable()
                    .frame(width: 225, height: 75)
                    .aspectRatio(contentMode: .fit)
            }
            .padding(.top, 100)
        

        }
        .background(.white)
        
    }
}



#Preview {
    ContentView()
}
