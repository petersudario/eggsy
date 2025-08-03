//
//  Game.swift
//  eggsy
//
//  Created by Pepo on 01/08/25.
//

import SwiftUI
import RouterKit

struct Game: View {
    @State private var currentQuestionIndex = 0
    @State private var answered = false
    @State private var showContinue = false
    @State private var answersState: [String: Bool] = [:]
    @EnvironmentObject var router: Router<AppRoute>
    
    let consequenceRules: [ConsequenceRule] = [
        ConsequenceRule(
            key: "didNotEatButPlayed",
            text: "Eggsy brincou, mas passou mal porque não comeu.",
            imageName: "pass_out",
            conditions: [("eat", false), ("play", true)]
        ),
        ConsequenceRule(
            key: "didNotGoToSchoolAndSocialized",
            text: "Eggsy foi excluído por ter faltado aula.",
            imageName: "eggsy_child",
            conditions: [("school", false), ("socialize", true)]
        ),
        ConsequenceRule(
            key: "didNotStudy",
            text: "Eggsy reprovou de ano.",
            imageName: "eggsy_child",
            conditions: [("study", false), ("exams", true)])
    ]
    
    private let questions: [Question] = [
        Question(
            id: "quack",
            text: "Fazer Quack?",
            imageName: "eggsy",
            yesResponse: "Eggsy fez quack.",
            noResponse: "Eggsy não fez quack.",
            yesImage: nil,
            noImage: nil,
            yesImageSize: nil,
            noImageSize: nil
        ),
        Question(
            id: "eat",
            text: "Comer?",
            imageName: "eggsy",
            yesResponse: "Eggsy comeu.",
            noResponse: "Eggsy não comeu.",
            yesImage: nil,
            noImage: nil,
            yesImageSize: nil,
            noImageSize: nil
        ),
        Question(
            id: "play",
            text: "Brincar com os amigos?",
            imageName: "friends",
            yesResponse: "Eggsy se divertiu muito com seus amigos.",
            noResponse: "Eggsy não brincou.",
            yesImage: "happy",
            noImage: "eggsy",
            yesImageSize: CGSize(width: 180, height: 180),
            noImageSize: CGSize(width: 180, height: 180)
        ),
        Question(
            id: "grow_up",
            text: "Crescer?",
            imageName: "eggsy",
            yesResponse: "Eggsy cresceu!",
            noResponse: "",
            yesImage: "eggsy_child",
            noImage: nil,
            yesImageSize: CGSize(width: 190, height: 270),
            noImageSize: nil
        ),
        Question(
            id: "school",
            text: "Ir para a escola?",
            imageName: "eggsy_child",
            yesResponse: "Eggsy foi para a aula.",
            noResponse: "Eggsy matou aula.",
            yesImage: "eggsy_child",
            noImage: nil,
            yesImageSize: CGSize(width: 190, height: 270),
            noImageSize: nil
        ),
        Question(
            id: "socialize",
            text: "Socializar\n com amigos?",
            imageName: "socialize",
            yesResponse: "Eggsy socializou com os amigos.",
            noResponse: "Eggsy não socializou.",
            yesImage: nil,
            noImage: nil,
            yesImageSize: nil,
            noImageSize: nil
        ),
        Question(
            id: "study",
            text: "Estudar até tarde?",
            imageName: "eggsy_child",
            yesResponse: "Eggsy estudou até tarde.",
            noResponse: "Eggsy não estudou até tarde.",
            yesImage: nil,
            noImage: nil,
            yesImageSize: nil,
            noImageSize: nil
        ),
        Question(
            id: "exams",
            text: "Ver notas?",
            imageName: "eggsy_child",
            yesResponse: "Eggsy passou de ano.",
            noResponse: "Eggsy não se importou\ncom as notas.",
            yesImage: nil,
            noImage: nil,
            yesImageSize: nil,
            noImageSize: nil
        ),
        Question(
            id: "grow_up",
            text: "Crescer?",
            imageName: "eggsy_child",
            yesResponse: "Eggsy cresceu\nmais!",
            noResponse: "",
            yesImage: "eggsy_adult",
            noImage: nil,
            yesImageSize: CGSize(width: 200, height: 360),
            noImageSize: nil
        ),
        Question(
            id: "college",
            text: "Ir para\nfaculdade?",
            imageName: "eggsy_adult_college",
            yesResponse: "Eggsy se matriculou,\nmas odeia o curso.",
            noResponse: "Eggsy não se matriculou.",
            yesImage: "eggsy_adult",
            noImage: "eggsy_adult",
            yesImageSize: CGSize(width: 200, height: 360),
            noImageSize: CGSize(width: 200, height: 360)
        ),
        Question(
            id: "give_up",
            text: "...Desistir?",
            imageName: "eggsy_adult",
            yesResponse: "....",
            noResponse: "....",
            yesImage: "eggsy_adult",
            noImage: "eggsy_adult",
            yesImageSize: CGSize(width: 200, height: 360),
            noImageSize: CGSize(width: 200, height: 360)
        ),
        
    ]
    
    var body: some View {
         // 🔒 Protege contra acesso fora do array
         if currentQuestionIndex >= questions.count {
             return AnyView(EmptyView())
         }

         let question = questions[currentQuestionIndex]
         
         return AnyView(
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
                                             answersState[question.id] = true
                                             showContinue = false
                                         }
                                     }
                                     if (question.noResponse != "") {
                                         ActionButton(text: "Não", width: 162, height: 165) {
                                             answered = true
                                             answersState[question.id] = false
                                             showContinue = false
                                         }
                                     }
                                 }
                             }
                         } else {
                             ZStack {
                                 Image("textbox")
                                 VStack(spacing: 12) {
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
         )
     }
     
     func applicableConsequence(for questionId: String) -> ConsequenceRule? {
         for rule in consequenceRules {
             let affectsCurrentQuestion = rule.conditions.contains(where: { $0.questionId == questionId })
             if !affectsCurrentQuestion { continue }
             
             let conditionsSatisfied = rule.conditions.allSatisfy { condition in
                 if let answer = answersState[condition.questionId] {
                     return answer == condition.expectedAnswer
                 }
                 return false
             }
             
             if conditionsSatisfied {
                 return rule
             }
         }
         return nil
     }
     
     func applyConsequences() -> String {
         let question = questions[currentQuestionIndex]
         
         if let consRule = applicableConsequence(for: question.id) {
             return consRule.text
         }
         
         if let answer = answersState[question.id] {
             return answer ? question.yesResponse : question.noResponse
         }
         
         return ""
     }
     
     func questionImage() -> (String, CGSize) {
         let question = questions[currentQuestionIndex]
         
         guard answered else {
             return (question.imageName, question.yesImageSize ?? CGSize(width: 165, height: 162))
         }
         
         if let consRule = applicableConsequence(for: question.id) {
             return (
                 consRule.imageName ?? question.imageName,
                 CGSize(width: 260, height: 328)
             )
         }
         
         if let answer = answersState[question.id] {
             if answer {
                 return (
                     question.yesImage ?? question.imageName,
                     question.yesImageSize ?? CGSize(width: 165, height: 162)
                 )
             } else {
                 return (
                     question.noImage ?? question.imageName,
                     question.noImageSize ?? CGSize(width: 165, height: 162)
                 )
             }
         }
         
         return (question.imageName, CGSize(width: 165, height: 162))
     }
     
     var badChoicesCount: Int {
         consequenceRules.reduce(0) { count, rule in
             let matched = rule.conditions.allSatisfy { condition in
                 answersState[condition.questionId] == condition.expectedAnswer
             }
             return count + (matched ? 1 : 0)
         }
     }
     
     func advanceToNextQuestion() {
         answered = false
         showContinue = false
         currentQuestionIndex += 1
         
         if currentQuestionIndex >= questions.count {
             let endingType: EndingType = badChoicesCount >= 2 ? .bad : .good
             router.push(to: .ending(type: endingType), animate: false)
             currentQuestionIndex = 0
             answersState = [:]
         }
     }
 }

 #Preview {
     Game()
 }
