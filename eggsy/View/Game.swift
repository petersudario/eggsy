//
//  Game.swift
//  eggsy
//
//  Created by Pepo on 01/08/25.
//
import SwiftUI

struct Game: View {
    @State private var currentQuestionIndex = 0
    @State private var answered: Bool = false
    @State private var answeredYes: Bool = false
    @State private var showContinue = false
    @State private var showConsequenceWarning = false
    
    @State private var consequenceState: [String: Bool] = [:]
    
    private let questions: [Question] = [
        Question(
            id: "quack",
            text: "Fazer Quack?",
            imageName: "eggsy",
            yesResponse: "Eggsy fez quack.",
            noResponse: "Eggsy não fez quack."
        ),
        Question(
            id: "eat",
            text: "Comer?",
            imageName: "eggsy",
            yesResponse: "Eggsy comeu.",
            noResponse: "Eggsy não comeu.",
            noHasConsequence: true,
            consequenceKey: "didNotEat"
        ),
        Question(
            id: "play",
            text: "Brincar com os amigos?",
            imageName: "friends",
            yesResponse: "Eggsy se divertiu muito com seus amigos.",
            noResponse: "Eggsy não brincou.",
            yesHasConsequence: true, noHasConsequence: false,
            consequenceKey: "didNotEat",
            consequenceText: "Eggsy brincou, mas passou mal",
            yesImage: "happy",
            noImage: "eggsy",
            yesConsequenceImage: "pass_out",
            noConsequenceImage: "eggsy",
            yesImageSize: CGSize(width: 180, height: 180),
            noImageSize: CGSize(width: 180, height: 180),
            yesConsequenceImageSize: CGSize(width: 260, height: 328),
            noConsequenceImageSize: CGSize(width: 210, height: 261)
        ),
        Question(
            id: "grow_up",
            text: "Crescer?",
            imageName: "eggsy",
            yesResponse: "Eggsy cresceu!",
            noResponse: "",
            yesImage: "eggsy_child",
            yesImageSize: CGSize(width: 190, height: 270)
        )
    ]
    
    var body: some View {
        let question = questions[currentQuestionIndex]
        
        ZStack {
            VStack {
                Spacer()
                
                let (imageName, imageSize) = questionImage()
                
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageSize.width, height: imageSize.height)
                
                Spacer()
                
                Group {
                    if !answered {
                        VStack(spacing: 30) {
                            Text(question.text)
                                .font(.custom("Chalkboy", size: 56))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                            
                            HStack(spacing: 40) {
                                if (question.yesResponse != "") {
                                    ActionButton(text: "Sim", width: 162, height: 165) {
                                        answered = true
                                        answeredYes = true
                                        
                                        showConsequenceWarning = (question.id == "comer" && question.yesHasConsequence == true)
                                    }
                                }
                                if (question.noResponse != "") {
                                    
                                    ActionButton(text: "Não", width: 162, height: 165) {
                                        answered = true
                                        answeredYes = false
                                        
                                        showConsequenceWarning = (question.id == "comer" && question.noHasConsequence == true)
                                    }
                                }
                            }
                        }
                    } else {
                        ZStack {
                            Image("textbox")
                            VStack (spacing: 12) {
                                if showConsequenceWarning {
                                    Text("Esta decisão vai ter consequências")
                                        .font(.custom("Chalkboy", size: 20))
                                        .foregroundColor(.red)
                                        .transition(.opacity)
                                }
                                
                                TypewriterText(
                                    fullText: applyConsequences(),
                                    speed: 0.05,
                                    fontName: "Chalkboy",
                                    fontSize: 26
                                ) {
                                    showContinue = true
                                }
                            }
                            
                            if showContinue {
                                BouncingImage(imageName: "continue_arrow", size: CGSize(width: 60, height: 27))
                                    .padding(.top, 150)
                            }
                        }
                        .onTapGesture {
                            if showContinue {
                                advanceToNextQuestion()
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 300)
                .background(Color.white.opacity(0.001))
            }
            .padding(.horizontal)
        }
    }
    
    func applyConsequences() -> String {
        let question = questions[currentQuestionIndex]
        
        if question.id == "play" && consequenceState["didNotEat"] == true {
            if answeredYes {
                return "Eggsy brincou, mas passou mal porque não comeu."
            } else {
                return question.noResponse
            }
        }
        
        if question.id == "eat" {
            return answeredYes ? question.yesResponse : question.noResponse
        }
        
        return answeredYes ? question.yesResponse : question.noResponse
    }
    
    
    
    func advanceToNextQuestion() {
        let question = questions[currentQuestionIndex]
        
        if !answeredYes, question.noHasConsequence == true, let key = question.consequenceKey {
            consequenceState[key] = true
        }
        
        showConsequenceWarning = false
        showContinue = false
        answered = false
        
        if currentQuestionIndex + 1 < questions.count {
            currentQuestionIndex += 1
        } else {
            print("fim")
        }
    }
    
    func questionImage() -> (String, CGSize) {
        let question = questions[currentQuestionIndex]
        
        guard answered else {
            return (
                question.imageName,
                question.imageSize ?? CGSize(width: 165, height: 162)
            )
        }
        
        let consequenceApplied = question.consequenceKey.map { consequenceState[$0] == true } ?? false
        
        if answeredYes {
            if consequenceApplied,
               let image = question.yesConsequenceImage {
                return (
                    image,
                    question.yesConsequenceImageSize ?? CGSize(width: 165, height: 162)
                )
            } else if let image = question.yesImage {
                return (
                    image,
                    question.yesImageSize ?? CGSize(width: 165, height: 162)
                )
            }
        } else {
            if consequenceApplied,
               let image = question.noConsequenceImage {
                return (
                    image,
                    question.noConsequenceImageSize ?? CGSize(width: 165, height: 162)
                )
            } else if let image = question.noImage {
                return (
                    image,
                    question.noImageSize ?? CGSize(width: 165, height: 162)
                )
            }
        }
        
        return (
            question.imageName,
            question.imageSize ?? CGSize(width: 165, height: 162)
        )
    }
}

#Preview {
    Game()
}
