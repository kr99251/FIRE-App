//
//  JournalsList.swift
//  Swift FIRE
//
//  Created by Noel Desmarais on 11/30/22.
//


import SwiftUI

struct JournalsList: View {
    @StateObject private var store = JournalStore()
    @Binding var journals: [JournalEntry]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewJournal = false
    @State private var newJournalEntryData = JournalEntry()
    @State var newEntryUpdated = false
    @Binding var currentState : appState
    @State private var showPopUp: Bool = false
    @State var goToHomeView: Bool = false
    var navy = Color(red: 0, green: 0, blue: 128/255)
    let saveAction: ()->Void
    
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack(alignment: .center) {
                    // Navigation link to go to main menu
                    NavigationLink(destination: Main(currentState : $currentState).navigationBarHidden(true), isActive: $goToHomeView) {
                        EmptyView()
                    }
                    VStack{
                        HStack {
                            // Navigation link becomes active when home button is pressed
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
                            // Font size button
                            Button(action: {showPopUp = true; saveData(appData:currentState)}) {
                                Text("Font Size")
                                    .frame(width: 80.0, height: 50)
                                    .foregroundColor(Color.white)
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white, lineWidth: 3)
                            )
                        }
                        .padding(.top, 50)
                        Text("Journals")
                            .font(.system(size: CGFloat(currentState.size + 10)) .bold())
                            .padding([.leading, .trailing, .top], 10)
                            .foregroundColor(Color.white)
                            .offset(y: -10)
                    }
                    .foregroundColor(Color.white)
                    .padding(20)
                    .background(.blue)
                    NavigationView {
                        VStack {
                            List {
                                ForEach($journals) { $journal in
                                    NavigationLink(destination: DetailView(journal: $journal, currentState: $currentState)) {
                                        CardView(journal: journal)
                                    }
                                }
                            }
                            .font(.system(size: CGFloat(currentState.size)))
                            
                            .foregroundColor(navy)
                            VStack {
                                Button(action: {
                                    isPresentingNewJournal = true
                                }) {
                                    Text("New Entry")
                                        .font(.system(size: CGFloat(currentState.size)))

                                }
                                .frame(width: .infinity, height: 75)
                                .padding()
                            }
                            .background(.white)
                            .frame(width: .infinity)
                            
                        }
                        .navigationBarHidden(true)
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
                .sheet(isPresented: $isPresentingNewJournal) {
                    NavigationView {
                        DetailEditView(data: $newJournalEntryData, currentState: $currentState)
                            .toolbar {
                                ToolbarItem(placement: .cancellationAction) {
                                    Button("Dismiss") {
                                        isPresentingNewJournal = false
                                        newJournalEntryData = JournalEntry()
                                    }.font(.system(size: CGFloat(currentState.size)))

                                }
                                ToolbarItem(placement: .confirmationAction) {
                                    Button("Add") {
                                        let _ = print("ADD")
                                        let date = Date()
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.dateFormat = "dd/MM/yyyy"
                                        
                                        let newJournalEntry = JournalEntry(title: newJournalEntryData.title, date: dateFormatter.string(from: date), content: newJournalEntryData.content)
                                        journals.append(newJournalEntry)
                                        isPresentingNewJournal = false
                                        newJournalEntryData = JournalEntry()
                                        saveAction()
                                    }.font(.system(size: CGFloat(currentState.size)))

                                }
                            }
                    }
                }

                .onChange(of: scenePhase) { phase in
                    if phase == .inactive { saveAction() }
                }
                .navigationBarHidden(true)
                .ignoresSafeArea()
            }
            
            // Font size popup window
            PopUpWindow(message: "Choose a font size:", buttonText: "Done", show: $showPopUp, currentState: $currentState)
        }
    }
        
}

struct JournalsList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            JournalsList(journals: .constant(JournalEntry.sampleData), currentState: .constant(appState()), saveAction: {})
            
        }
    }
}
