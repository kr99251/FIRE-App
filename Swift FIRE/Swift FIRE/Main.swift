//
//  Main.swift
//  Swift FIRE
//
//  Created by Emma Shroyer on 10/26/22.
//

import SwiftUI

struct Main: View {
    @State var goToModuleView: Bool = false
    @State var goToQuizView: Bool = false
    @State var goToJournalView: Bool = false
    @State var goToChecklistView: Bool = false
    //https://stackoverflow.com/questions/56437335/go-to-a-new-view-using-swiftui
    @Binding var currentState : appState
    var navy = Color(red: 0, green: 0, blue: 128/255)
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Image("FIRE-Logo-Medium")
                    .resizable()
                    .scaledToFit()
                    .padding()
                Group{
                    NavigationLink(destination: ModuleListView(currentState: $currentState).navigationBarHidden(true), isActive: $goToModuleView) {
                        EmptyView()
                    }
                    NavigationLink(destination: QuizList(currentState: $currentState).navigationBarHidden(true), isActive: $goToQuizView) {
                        EmptyView()
                    }
                    NavigationLink(destination: JournalList(currentState: $currentState).navigationBarHidden(true), isActive: $goToJournalView) {
                        EmptyView()
                    }
                    NavigationLink(destination: ChecklistList(currentState: $currentState).navigationBarHidden(true), isActive: $goToChecklistView) {
                        EmptyView()
                    }
                }
                HStack {
                    Button(action: {self.goToModuleView = true}) {
                        Text("Modules")
                            .frame(width: UIScreen.screenWidth / 3, height: 150)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(navy, lineWidth: 5)
                    )
                    Spacer()
                        .frame(width: UIScreen.screenWidth/24, height: 1)
                    Button(action: {self.goToQuizView = true}) {
                        Text("Quizzes")
                            .frame(width: UIScreen.screenWidth / 3, height: 150)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(navy, lineWidth: 5)
                    )
                }
                Spacer()
                HStack {
                    Button(action: {self.goToJournalView = true}) {
                        Text("Journal")
                            .frame(width: UIScreen.screenWidth / 3, height: 150)
                    }
                    .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(navy, lineWidth: 5)
                            )
                    Spacer()
                        .frame(width: UIScreen.screenWidth/24, height: 1)
                    Button(action: {self.goToChecklistView = true}) {
                        Text("Checklists")
                            .frame(width: UIScreen.screenWidth / 3, height: 150)
                    }
                    .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(navy, lineWidth: 5)
                            )
                }
                Spacer()
                HStack{
                    Text("Modules: \n \(100*currentState.moduleCompletionArray.filter{$0 == true}.count/currentState.moduleCompletionArray.count) % Completed")
                        .multilineTextAlignment(.center)
                        .padding(10)
                        .font(.system(size: CGFloat(currentState.size + 5)))
                    Text("Checklists: \n \(100*currentState.checklistCompletionArray.filter{$0 == true}.count/currentState.checklistCompletionArray.count) % Completed")
                        .multilineTextAlignment(.center)
                        .padding(10)
                        .font(.system(size: CGFloat(currentState.size + 5)))
                }
            }
            .buttonStyle(.bordered)
            .font(.title2 .bold())
            .foregroundColor(navy)
            .background(Color.white)
            .padding()
            .tint(.white)
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct Previews_Main_Previews: PreviewProvider {
    static var previews: some View {
        Main(currentState: .constant(appState()))
            .environmentObject(ModelData())
    }
}
