//
//  DetailView.swift
//  Swift FIRE
//
//  Created by Noel Desmarais on 11/30/22.
//

import SwiftUI

struct DetailView: View {
    @Binding var journal: JournalEntry
    
    @State private var newEntry = JournalEntry()
    @State private var isPresentingEditView = false
    
    var body: some View {
        Section{
            VStack{
                HStack{
                    Text(journal.title)
                        .font(.title)
                    Spacer()
                }
                HStack{
                    Text("Journal - \(journal.date)")
                        .font(.subheadline)
                    Spacer()

                }
                .padding([.bottom, .leading])
                .frame(alignment: .leading)

                Text(journal.content)
                    .frame(height: .infinity, alignment: .leading)
                Spacer()
            }
            .padding()
        }
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
                newEntry = journal
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationView {
                DetailEditView(data: $newEntry)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                journal = newEntry
                            }
                        }
                    }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(journal: .constant(JournalEntry.sampleData[0]))
        }
    }
}

