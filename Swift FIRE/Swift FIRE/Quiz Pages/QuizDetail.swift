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
    
    var body: some View {
        let numQuestions = quiz.questions.count
        ScrollView {
            if index < numQuestions {
                let currQuestion = quiz.questions[index]
                let currAnswers = quiz.answers[index]
                var added = 0
                var color = Color.white
                
                VStack {
                    Text(currQuestion)
                    Spacer()
                    
                    List(0..<currAnswers.count, id: \.self) { num in
                        Button(action: {
                            added = currAnswers[num].points
                            color = Color.green
                        }) {
                            Text(currAnswers[num].answer)
                                .foregroundColor(color)
                        }
                    }
                    Spacer()
                    
                    (index + 1 == numQuestions) ?
                        Button(action: {
                            index += 1
                        }) {
                        Text("Finish")
                            .frame(width: 80.0, height: 50)
                            .foregroundColor(Color.white)
                    } : Button(action: {
                        index += 1
                        sum += added
                    }) {
                        Text("Next")
                            .frame(width: 80.0, height: 50)
                            .foregroundColor(Color.white)
                    }
                }
            } else {
                VStack {
                    let result = findResult(options: quiz.results, sum: sum)
                    Text(result.result)
                    Text(result.description)
                    
                    NavigationLink(destination: QuizList().navigationBarHidden(true), isActive: $goToQuizView) {
                        EmptyView()
                    }
                    
                    Button(action: {self.goToQuizView = true}) {
                        Text("More Quizzes!")
                    }
                }
            }
        }
        .navigationTitle(quiz.quizName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct QuizDetail_Previews: PreviewProvider {
    static var previews: some View {
        QuizDetail(quiz: ModelData().quizzes[1])
            .environmentObject(ModelData())
    }
}

func findResult(options: [Result], sum: Int) -> Result {
    for result in options {
        if (sum >= result.pointMin) {
            return result
        }
    }
    return options[options.count-1]
}
