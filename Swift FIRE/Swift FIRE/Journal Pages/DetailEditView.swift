//
//  DetailEditView.swift
//  Swift FIRE
//
//  Created by Noel Desmarais on 11/30/22.
//

import SwiftUI

struct DetailEditView: View {
    @Binding var data: JournalEntry
    @State private var newJournalContent = ""
    @State private var newJournalTitle = ""
    
    var body: some View {
        List{
            Section(header: Text("Journal Title")){
                TextField("Title", text: $data.title)
                    .font(.title)
            }
            HStack{
                Text("Journal - \(data.date)")
                    .font(.subheadline)
                Spacer()
            }
            Section{
                TextEditor(text: $data.content)

            }
        }

        .frame(maxHeight: .infinity)
    }
}


struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DetailEditView(data: .constant(JournalEntry.sampleData[0]))
        }
    }
}

