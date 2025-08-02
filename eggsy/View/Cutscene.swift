//
//  Game.swift
//  eggsy
//
//  Created by Pepo on 01/08/25.
//

import SwiftUI
import AVFoundation
import RouterKit

struct Cutscene: View {
    @State private var currentStepIndex = 0
    @State private var showContinue = false
    @State private var currentEggImage = "egg"
    @State private var displayedText: String? = nil
    @State private var typingText: String? = nil
    @State private var finishedTyping = false
    @State private var audioPlayer: AVAudioPlayer?
    @State private var waitingForButton = false
    @State private var actionButtonTitle = ""
    @State private var soloImageName: String? = nil
    @State private var soloImageSize: CGSize = .zero
    @State private var showBackground = true
    @State private var showEgg = true
    
    @EnvironmentObject var router: Router<AppRoute>
    
    let cutscene: [CutsceneStep] = [
        .typewriter("A mamãe pato botou um\novo..."),
        .typewriter("Era um ovo pequeno,\ntímido, nada confiante."),
        .changeImage("egg_cracked"),
        .showText("CLACK!"),
        .typewriter("Muito tempo se passou e o\npatinho não saiu do ovo..."),
        .typewriter("O patinho estava muito\nsaudável e pronto para sair."),
        .showText("silêncio..."),
        .typewriter("Mas não saia de jeito\nnenhum."),
        .waitForButton(title: "Sair"),
        .showSoloImage(name: "birth", size: CGSize(width: 212, height: 300)),
        .showSoloImage(name: "eggsy", size: CGSize(width: 164, height: 162)),
        .typewriter("Quando a mamãe pato\npediu para que ele saísse.."),
        .typewriter("Ele incrivelmente saiu."),
        .typewriter("A mamae pato o nomeou de..."),
        .showText("EGGSY."),
        .showSoloImage(name: "confused", size: CGSize(width: 105, height: 238)),
        .typewriter("Porem ele nasceu com\numa dificuldade..."),
        .showSoloImage(name: "confused_2", size: CGSize(width: 170, height: 238)),
        .typewriter("Ele não conseguia tomar\ndecisoes."),
    ]
    
    func advanceCutscene() {
        guard currentStepIndex < cutscene.count else { return }
        
        let step = cutscene[currentStepIndex]
        currentStepIndex += 1
        showContinue = false
        displayedText = nil
        typingText = nil
        finishedTyping = false
        
        switch step {
        case .showText(let text):
            displayedText = text
            showContinue = true
            
        case .changeImage(let imageName):
            currentEggImage = imageName

            if imageName == "egg_cracked" {
                playSound(named: "crack")
            }

            advanceCutscene()
            
        case .typewriter(let text):
            typingText = text
            
        case .playSound(let soundName):
            playSound(named: soundName)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                advanceCutscene()
            }
            
        case .waitForButton(let title):
            actionButtonTitle = title
            waitingForButton = true
            
        case .showSoloImage(let name, let size):
            soloImageName = name
            soloImageSize = size
            showContinue = true
            
        }
    }
    
    func playSound(named soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {
            print("⚠️ Sound file \(soundName).mp3 not found")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("⚠️ Failed to play sound: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        VStack(spacing: 90) {
            VStack {
                VStack {
                    ZStack {
                        AnimatedBackgroundView(images: ["rabisco_1", "rabisco_2", "rabisco_3"])
                            .frame(width: 305, height: 300)
                            .opacity(showBackground ? 1 : 0)
                            .animation(.easeOut(duration: 0.5), value: showBackground)
                        
                        Image(currentEggImage)
                            .resizable()
                            .frame(width: 182, height: 244)
                            .opacity(showEgg ? 1 : 0)
                            .animation(.easeOut(duration: 0.5), value: showEgg)
                        
                        if let soloName = soloImageName {
                            VStack {
                                Image(soloName)
                                    .resizable()
                                    .frame(width: soloImageSize.width, height: soloImageSize.height)
                                    .padding(.top, 100)
                                Spacer()
                                if showContinue && (typingText == nil && displayedText == nil) {
                                    BouncingImage(imageName: "continue_arrow", size: CGSize(width: 60, height: 27))
                                        .padding(.top, 150)
                                }
                            }
                            
                        }
                    }
                    if let displayed = displayedText {
                        Text(displayed)
                            .font(.custom("Chalkboy", size: 116))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                        
                        
                    }
                }
                Spacer()
                if showContinue && displayedText != nil {
                    BouncingImage(imageName: "continue_arrow", size: CGSize(width: 60, height: 27))
                        .padding(.top, 150)
                }
                
                
            }
            .padding(.top, 150)
            
            if waitingForButton {
                ActionButton(text: actionButtonTitle, action: {
                    withAnimation {
                        showBackground = false
                        showEgg = false
                    }
                    waitingForButton = false
                    actionButtonTitle = ""
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        advanceCutscene()
                        
                        showContinue = true
                        
                    }
                })
                .padding(.top, 40)
            }
            else if let typing = typingText {
                ZStack {
                    Image("textbox")
                    VStack {
                        TypewriterText(
                            fullText: typing,
                            speed: 0.05,
                            fontName: "Chalkboy",
                            fontSize: 26
                        ) {
                            finishedTyping = true
                            showContinue = true
                        }
                        .id(typing)
                    }
                    
                    if showContinue {
                        BouncingImage(imageName: "continue_arrow", size: CGSize(width: 60, height: 27))
                            .padding(.top, 150)
                    }
                }
            }
        }
        .onTapGesture {
            if showContinue {
                if currentStepIndex >= cutscene.count {
                    router.push(to: .game, animate: false)
                } else {
                    advanceCutscene()
                }
            }
        }
        
        .onAppear {
            advanceCutscene()
        }
    }
}

#Preview {
    Cutscene()
}
