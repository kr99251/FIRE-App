//
//  JournalsList.swift
//  Swift FIRE
//
//  Created by Noel Desmarais on 11/30/22.
//
/*
See LICENSE folder for this sample’s licensing information.
*/

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



    let saveAction: ()->Void
    
    var body: some View {
        let startFont: CGFloat = 35
        ZStack{
        NavigationView{
            VStack{
                HStack {
                    NavigationLink(destination: Main(currentState: $currentState).navigationBarHidden(true)) {
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
                .padding()
                .background(.blue)

            List {
                ForEach($journals) { $journal in
                    NavigationLink(destination: DetailView(journal: $journal)) {
                        CardView(journal: journal)
                    }
                }
            }
            .background(.green)
            .padding(.top, 0)
            
            VStack {
                Button(action: {
                    isPresentingNewJournal = true
                }) {
                    Text("New Entry")
                }
                .frame(width: .infinity, height: 75)
                .padding()
            }
            .background(.white)
            .frame(width: .infinity)
        }.onAppear{
            JournalStore.load { result in
                switch result {
                case .failure(let error):
                    fatalError(error.localizedDescription)
                case .success(let journals):
                    store.journals = journals
                }
            }
        }
        .ignoresSafeArea()

//
//        .toolbar {
//            Button(action: {
//                isPresentingNewJournal = true
//            }) {
//                Image(systemName: "plus")
//            }
//        }
        .sheet(isPresented: $isPresentingNewJournal) {
            NavigationView {
                DetailEditView(data: $newJournalEntryData)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingNewJournal = false
                                newJournalEntryData = JournalEntry()
                            }
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
                            }
                        }
                    }
            }
        }

        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
            
    }
    PopUpWindow(message: "Choose a font size:", buttonText: "Done", show: $showPopUp, currentState: $currentState)
    }
        
    }
}

struct JournalsList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            JournalsList(journals: .constant(JournalEntry.sampleData), saveAction: {})
            
        }
    }
}
