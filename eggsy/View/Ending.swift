//
//  Ending.swift
//  eggsy
//
//  Created by Pepo on 02/08/25.
//

import SwiftUI
import AVFoundation
import RouterKit

struct Ending: View {
    let type: EndingType

    @State private var currentStepIndex = 0
    @State private var displayedText: String?
    @State private var typingText: String?
    @State private var showContinue = false
    @State private var waitingForButton = false
    @State private var actionButtonTitle = ""
    @State private var soloImageName: String?
    @State private var soloImageSize: CGSize = .zero
    @State private var audioPlayer: AVAudioPlayer?

    @EnvironmentObject var router: Router<AppRoute>

    var cutscene: [CutsceneStep] {
        switch type {
        case .good:
            return [
                .typewriter("Você tomou boas\ndecisoes por Eggsy."),
                .typewriter("Mas nada do que escolheu,\nera o que ele queria."),
                .typewriter("Ele nao pode depender para,\nsempre de alguem."),
                .typewriter("Apesar de tudo,\nele te agradece."),
                .typewriter("Nao deixe ninguem te \ndizer o que deve fazer."),
                .typewriter("Eggsy te escuta uma ultima\nvez, e nao desiste."),
                .typewriter("Final feliz."),
                .waitForButton(title: "Retry")
            ]
        case .bad:
            return [
                .typewriter("...Eggsy não esta feliz com\n as escolhas que tomou."),
                .typewriter("Eggsy parou de\nescutar suas decisoes."),
                .typewriter("Apesar de tudo, ele\nte agradece por tentar."),
                .typewriter("Nao deixe ninguem te \ndizer o que deve fazer."),
                .typewriter("Eggsy não desistiu."),
                .typewriter("Final ruim."),
                .waitForButton(title: "Retry")
            ]
        }
    }

    func advanceCutscene() {
        guard currentStepIndex < cutscene.count else { return }

        let step = cutscene[currentStepIndex]
        currentStepIndex += 1

        displayedText = nil
        typingText = nil
        showContinue = false
        waitingForButton = false

        switch step {
        case .showText(let text):
            displayedText = text
            showContinue = true

        case .changeImage:
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
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("⚠️ Falha ao tocar som: \(error.localizedDescription)")
        }
    }

    var body: some View {
        VStack(spacing: 90) {
            VStack {
                if let displayed = displayedText {
                    Text(displayed)
                        .font(.custom("Chalkboy", size: 116))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                }

                if showContinue && displayedText != nil {
                    BouncingImage(imageName: "continue_arrow", size: CGSize(width: 60, height: 27))
                        .padding(.top, 150)
                }
            }

            if waitingForButton {
                ActionButton(text: actionButtonTitle) {
                    router.push(to: .startscreen, animate: false)
                }
                .padding(.top, 40)

            } else if let typing = typingText {
                ZStack {
                    Image("textbox")
                    VStack {
                        TypewriterText(
                            fullText: typing,
                            speed: 0.05,
                            fontName: "Chalkboy",
                            fontSize: 26
                        ) {
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
            if showContinue && !waitingForButton {
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
    Ending(type: .bad)
}
