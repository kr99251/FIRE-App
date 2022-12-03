//
//  DetailEditView.swift
//  Swift FIRE
//
//  Created by Noel Desmarais on 11/30/22.
//

import SwiftUI

struct DetailEditView: View {
    @Binding var data: JournalEntry
    @Binding var currentState: appState
    @State private var newJournalContent = ""
    @State private var newJournalTitle = ""
    
    var body: some View {
        List{
            Section(header: Text("Journal Title")){
                TextField("Title", text: $data.title)
                    .font(.system(size: CGFloat(currentState.size + 10)))
            }
            HStack{
                Text("Journal - \(data.date)")
                    .font(.subheadline)
                Spacer()
            }
            Section{
                TextEditor(text: $data.content)

            }
        }.frame(maxHeight: .infinity)


    }
}


struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DetailEditView(data: .constant(JournalEntry.sampleData[0]), currentState: .constant(appState()))
        }
    }
}

