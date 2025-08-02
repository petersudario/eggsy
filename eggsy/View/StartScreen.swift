//
//  StartScreen.swift
//  eggsy
//
//  Created by Pepo on 01/08/25.
//

import SwiftUI
import RouterKit

struct StartScreen: View {
    @EnvironmentObject var router: Router<AppRoute>
    
    var body: some View {
        ZStack {
            AnimatedBackgroundView(images: ["animated_background_1", "animated_background_2", "animated_background_3"])

            VStack (spacing: 200){
                Image("game_starting_logo")
                    .resizable()
                    .frame(width: 209, height: 215)
                
                    .aspectRatio(contentMode: .fit)
            
                ActionButton(text: "START", action: {
                    router.push(to: .cutscene, animate: false)

                })


            }
            .padding(.top, 150)
        

        }
        .background(.white)
        
    }
}

#Preview {
    StartScreen()
}
