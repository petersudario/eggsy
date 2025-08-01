//
//  ContentView.swift
//  eggsy
//
//  Created by Pepo on 29/07/25.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    
    var body: some View {
        ZStack {
            AnimatedBackgroundView(images: ["animated_background_1", "animated_background_2", "animated_background_3"])

            VStack (spacing: 200){
                Image("game_starting_logo")
                    .resizable()
                    .frame(width: 209, height: 215)
                
                    .aspectRatio(contentMode: .fit)
            
                ActionButton(text: "START")


            }
            .padding(.top, 150)
        

        }
        .background(.white)
        
    }
    
}



#Preview {
    ContentView()
    
    
}
