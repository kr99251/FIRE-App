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
    @StateObject private var store = JournalStore()
    @Binding var currentState : appState
    @State private var isPresentingContact = false
    var checklistPercent = getChecklistPercent()
    var navy = Color(red: 0, green: 0, blue: 128/255)
    var body: some View {
        NavigationView {
            VStack {
                Image("FIRE-Logo-Medium")
                    .resizable()
                    .scaledToFit()
                    .padding(.top, 0)
                    .padding(.bottom, -30)
                Group{
                    NavigationLink(destination: ModuleListView(currentState: $currentState).navigationBarHidden(true), isActive: $goToModuleView) {
                        EmptyView()
                    }
                    NavigationLink(destination: QuizList(currentState: $currentState).navigationBarHidden(true), isActive: $goToQuizView) {
                        EmptyView()
                    }
                    NavigationLink(destination: JournalsList( journals: $store.journals, currentState: $currentState){
                        JournalStore.save(journals: store.journals){ result in
                            if case .failure(let error) = result {
                                fatalError(error.localizedDescription)
                            }
                        }
                        
                    }
                    .navigationBarHidden(true), isActive: $goToJournalView) {
                    EmptyView()
                    }

                    NavigationLink(destination: ChecklistList(currentState: $currentState).navigationBarHidden(true), isActive: $goToChecklistView) {
                        EmptyView()
                    }
                }

                HStack {
                    Button(action: {self.goToModuleView = true}) {
                        VStack{
                            Text("Modules")
                                .padding(.bottom)
                            Text("\(100*currentState.moduleCompletionArray.filter{$0 == true}.count/currentState.moduleCompletionArray.count)%")
                                .opacity(0.6)
                        }
                        .frame(width: UIScreen.screenWidth / 3, height: UIScreen.screenHeight / 5)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(navy, lineWidth: 5)
                    )
                    Spacer()
                        .frame(width: UIScreen.screenWidth/24, height: 1)
                    Button(action: {self.goToChecklistView = true}) {
                        VStack{
                            Text("Checklists")
                                .padding(.bottom)
                            Text("\(checklistPercent)%")
                                .opacity(0.6)
                        }
                        .frame(width: UIScreen.screenWidth / 3, height: UIScreen.screenHeight / 5)
                    }
                    .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(navy, lineWidth: 5)
                            )
                }
                .padding(.top, 0)
                Spacer()
                    .frame(width: 1, height: UIScreen.screenHeight / 20)
                HStack {
                    Button(action: {self.goToJournalView = true}) {
                        Text("Journal")
                            .frame(width: UIScreen.screenWidth / 3, height: UIScreen.screenHeight / 5)
                    }
                    .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(navy, lineWidth: 5)
                            )
                    Spacer()
                        .frame(width: UIScreen.screenWidth/24, height: 1)
                    Button(action: {self.goToQuizView = true}) {
                        Text("Quizzes")
                            .frame(width: UIScreen.screenWidth / 3, height: UIScreen.screenHeight / 5)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(navy, lineWidth: 5)
                    )
                }
                Spacer()
                    .frame(width: 1, height: UIScreen.screenHeight / 10)
                Button(action: {
                    isPresentingContact = true
                }) {
                    Text("Contact")
                        .font(.system(size: CGFloat(currentState.size)))


                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(navy, lineWidth: 5)
                    .frame(width: UIScreen.screenWidth-50)                        )
                
                .frame(width: UIScreen.screenWidth, height: 5)
                .padding(.bottom)
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
        .sheet(isPresented: $isPresentingContact) {
            NavigationView {
                Contact(currentState: $currentState)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Exit") {
                                isPresentingContact = false
                            }
                        }
                    }
            }
        }
        .onAppear{
        JournalStore.load { result in
            switch result {
            case .failure(let error):
                fatalError(error.localizedDescription)
            case .success(let journals):
                store.journals = journals
            }
        }
        }
        .preferredColorScheme(.light)


    }
        }

struct Previews_Main_Previews: PreviewProvider {
    static var previews: some View {
        Main(currentState: .constant(appState()))
            .environmentObject(ModelData())
    }
}
