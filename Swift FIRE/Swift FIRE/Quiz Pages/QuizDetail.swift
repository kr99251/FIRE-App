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
    @State var added: Int = 0
    @State var color = Color.blue
    
    var body: some View {
        if index < numQuestions {
            let currQuestion = quiz.questions[index]
            let currAnswers = quiz.answers[index]
            let currPoints = quiz.points[index]
            
            VStack {
                Text(currQuestion)
                Spacer()
                
                List(0..<currAnswers.count, id: \.self) { num in
                    Button(action: {
                        added = currPoints[num]
                        color = Color.green
                    }) {
                        Text("\(currAnswers[num]), \(added)")
                            .foregroundColor(color)
                    }
                }
                
                (index + 1 == numQuestions) ?
                    Button(action: {
                        index += 1
                    }) {
                    Text("Finish")
                        .frame(width: 80.0, height: 50)
                        .foregroundColor(Color.blue)
                } : Button(action: {
                    index += 1
                    sum += added
                    added = 0
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
                Text(result[1])
                
                NavigationLink(destination: QuizList().navigationBarHidden(true), isActive: $goToQuizView) {
                    EmptyView()
                }
                
                Button(action: {self.goToQuizView = true}) {
                    Text("More Quizzes!")
                }
            }
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
    for i in 1...options.count {
        if (sum >= points[i]) {
            return options[i]
        }
    }
    return options[options.count-1]
}
