//
//  QuizList.swift
//  Swift FIRE
//
//  Created by Kelly Robinett on 11/20/22.
//

import SwiftUI

struct QuizList: View {
    @EnvironmentObject var quizData: ModelData
    
    let navy = Color(red: 0, green: 0, blue: 128/255)
    let blue = Color(red: 50/255, green: 150/255, blue: 255/255)
//    @State var title = "Quizzes"
    @State var increaseAmount: Int = 0
    @State var currentValue = 1
    @State var goToHomeView: Bool = false
    @State var goToQuizView: Bool = false
    @State public var size: Double
    @State private var showPopUp: Bool = false
    
    var body: some View {
        var title = "Quizzes"
        ZStack {
            NavigationView {
                VStack(alignment: .center) {
                    NavigationLink(destination: Main(size: size ).navigationBarHidden(true), isActive: $goToHomeView) {
                        EmptyView()
                    }
                    HStack {
                        Button(action: {self.goToHomeView = true}) {
                            Text("Home")
                                .frame(width: 80.0, height: 50)
                                .foregroundColor(Color.white)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 3)
                        )
                        Spacer()
                        Button(action: {showPopUp = true}) {
                            Text("Font Size")
                                .frame(width: 80.0, height: 50)
                                .foregroundColor(Color.white)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 3)
                        )
                    }
                    .foregroundColor(Color.white)
                    .padding(20)
                    Text(title)
                        .font(.largeTitle .bold())
                        .padding([.leading, .trailing, .top], 10)
                        .foregroundColor(Color.white)
                        .offset(y: -10)
                    NavigationView {
                        List(quizData.quizzes) { quiz in
                            NavigationLink {
                                QuizDetail(quiz: quiz, numQuestions: quiz.questions.count, size: size)
                            } label: {
                                HStack {
                                    Text("\(quiz.quizName)")
                                }
                            }
                            .padding([.top, .bottom], 20)
                            .navigationTitle("Quizzes")
                            //                        Button(action: {
                            //                            self.goToQuizView = true
                            //                        }) {
                            //                            Text(quiz.quizName)
                            //                        }
                            //                        NavigationLink(destination: QuizDetail(quiz: quiz, numQuestions: quiz.questions.count), isActive: $goToQuizView) {
                            //                            EmptyView()
                            //                        }
                            
                        }
                        .listStyle(.insetGrouped)
                        .background(navy)
                        .font(.system(size: CGFloat(size)))
                        .foregroundColor(navy)
                        
                        .navigationTitle("")
                        .navigationBarHidden(true)
                    }
                }
                .background(blue)
                .navigationTitle("")
                .navigationBarHidden(true)
                
            }
            PopUpWindow(title: "Font Size", message: "Choose a font size:", buttonText: "Done", show: $showPopUp, size: $size)
        }
    }
}

struct QuizList_Previews: PreviewProvider {
    static var previews: some View {
        QuizList(size: 20.0)
            .environmentObject(ModelData())
    }
}
