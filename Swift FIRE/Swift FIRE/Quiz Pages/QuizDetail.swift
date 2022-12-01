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
    var size: Double
    
    var body: some View {
        let navy = Color(red: 0, green: 0, blue: 128/255)
        if index < numQuestions {
            // Get the current question, answers, and points for each answer
            let currQuestion = quiz.questions[index]
            let currAnswers = quiz.answers[index]
            let currPoints = quiz.points[index]
//            let colors = initColors(size: currAnswers.count, selectedIndex: selectedIndex)
            
            VStack {
                // Display the question
                Text(currQuestion)
                    .multilineTextAlignment(.center)
                    .font(.system(size: CGFloat(size)) .bold())
                    .padding([.leading, .trailing, .top], 5)
                    .offset(y: -20)
                    .minimumScaleFactor(0.01)
                Spacer()
                
                // Display all the answers
                List(0..<currAnswers.count, id: \.self) { num in
                    HStack {
                        Button(action: {
                            // set added to the points for num and selected index to num
                            added = currPoints[num]
                            selectedIndex = num
                        }) {
                            Text(currAnswers[num])
                                .foregroundColor(navy)
                        }
                        Spacer()
                        // check if the answer was selected
                        Text(selectedIndex == num ? "✅" : "🔲")
                    }
                    .font(.system(size: CGFloat(size)))
                }
                
                (index + 1 == numQuestions) ?
                    Button(action: {
                        // increase question index if something was selected
                        if added >= 0 {
                            index += 1
                        }
                    }) {
                    // if last question display 'Finish' at bottom
                    Text("Finish")
                        .frame(width: 80.0, height: 50)
                        .foregroundColor(Color.blue)
                } : Button(action: {
                    // increase question index and sum and reset added and selectedIndex if something was selected
                    if added >= 0 {
                        index += 1
                        sum += added
                        added = -1
                        selectedIndex = -1
                    }
                }) {
                    // if not last question display 'Next' at bottom
                    Text("Next")
                        .frame(width: 80.0, height: 50)
                        .foregroundColor(Color.blue)
                }
            }
        } else {
            VStack {
                // Find and display the result after the quiz is done
                let result = findResult(options: quiz.results, points: quiz.sums, sum: sum)
                Text(result[0])
                    .multilineTextAlignment(.center)
                    .font(.system(size: CGFloat(size + 10)) .bold())
                    .padding([.leading, .trailing], 5)
                    .foregroundColor(navy)
                    .offset(y: -50)
                Text(result[1])
            }
            .padding()
        }
    }
}

struct QuizDetail_Previews: PreviewProvider {
    static var previews: some View {
        QuizDetail(quiz: ModelData().quizzes[1], numQuestions: ModelData().quizzes[1].questions.count, size: 20.0)
            .environmentObject(ModelData())
    }
}

// function to find the correct result given the total number of points accumulated
func findResult(options: [[String]], points: [Int], sum: Int) -> [String] {
    for i in 0...options.count-1 {
        if (sum >= points[i]) {
            return options[i]
        }
    }
    return options[options.count-1]
}

//func initColors(size: Int, selectedIndex: Int) -> [Color]{
//    var colors: [Color] = []
//    for _ in 0...size-1 {
//        colors.append(Color.blue)
//    }
//    if (selectedIndex >= 0 && selectedIndex < size) {
//        colors[selectedIndex] = Color.green
//    }
//    return colors
//}
