//
//  QuizDetail.swift
//  Swift FIRE
//
//  Created by Kelly Robinett on 11/20/22.
//

import SwiftUI

struct QuizDetail: View {
    @State var quiz: Quiz
    @State var index = 0
    @State var sum: Int = 0
    @State var goToQuizView = false
    @State var numQuestions: Int
    @State var added: Int = -1
    @State var selectedIndex: Int = -1
    
    var body: some View {
        let navy = Color(red: 0, green: 0, blue: 128/255)
        if index < numQuestions {
            let currQuestion = quiz.questions[index]
            let currAnswers = quiz.answers[index]
            let currPoints = quiz.points[index]
            let colors = initColors(size: currAnswers.count, selectedIndex: selectedIndex)
            
            VStack {
                Text(currQuestion)
                    .multilineTextAlignment(.center)
                    .font(.title .bold())
//                    .padding([.leading, .trailing, .top], 5)
                    .offset(y: -20)
                Spacer()
                List(0..<currAnswers.count, id: \.self) { num in
                    HStack {
                        Button(action: {
                            added = currPoints[num]
                            selectedIndex = num
                        }) {
                            Text(currAnswers[num])
                                .foregroundColor(navy)
                        }
                        Spacer()
                        Text(selectedIndex == num ? "✅" : "🔲")
                    }
                }
                
                (index + 1 == numQuestions) ?
                    Button(action: {
                        if added >= -1 {
                            index += 1
                        }
                    }) {
                    Text("Finish")
                        .frame(width: 80.0, height: 50)
                        .foregroundColor(Color.blue)
                } : Button(action: {
                    if added >= 0 {
                        index += 1
                        sum += added
                        added = -1
                        selectedIndex = -1
                    }
                }) {
                    Text("Next")
                        .frame(width: 80.0, height: 50)
                        .foregroundColor(Color.blue)
                }
            }
        } else {
            VStack {
                let result = findResult(options: quiz.results, points: quiz.sums, sum: sum)
                Text(result[0])
                    .multilineTextAlignment(.center)
                    .font(.title .bold())
                    .frame(height: 4*UIScreen.screenHeight / 15)
                    .padding([.leading, .trailing, .top], 5)
                    .foregroundColor(navy)
                    .offset(y: -50)
                Text(result[1])
                
//                NavigationLink(destination: QuizList().navigationBarHidden(true), isActive: $goToQuizView) {
//                    EmptyView()
//                }
//                .navigationTitle("")
//                .navigationBarHidden(true)
                
//                Button(action: {self.goToQuizView = true}) {
//                    Text("More Quizzes!")
//                }
            }
            .padding()
        }
    }
}

struct QuizDetail_Previews: PreviewProvider {
    static var previews: some View {
        QuizDetail(quiz: ModelData().quizzes[1], numQuestions: ModelData().quizzes[1].questions.count)
            .environmentObject(ModelData())
    }
}

func findResult(options: [[String]], points: [Int], sum: Int) -> [String] {
    for i in 0...options.count-1 {
        if (sum >= points[i]) {
            return options[i]
        }
    }
    return options[options.count-1]
}

func initColors(size: Int, selectedIndex: Int) -> [Color]{
    var colors: [Color] = []
    for _ in 0...size-1 {
        colors.append(Color.blue)
    }
    if (selectedIndex >= 0 && selectedIndex < size) {
        colors[selectedIndex] = Color.green
    }
    return colors
}
