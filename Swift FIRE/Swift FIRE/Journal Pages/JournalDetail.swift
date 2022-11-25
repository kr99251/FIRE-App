

//
//  JournalDetail.swift
//  Swift FIRE
//
//  Created by Noel Desmarais on 11/9/22.
//
import SwiftUI

struct JournalDetail: View {
    @EnvironmentObject var modelData: ModelData
//    @Binding var content: String
//    @State private var data = Journal.Journal()
    @State var journal: Journal

    
    var index: Int {
        modelData.journals.firstIndex(where: { $0.id == journal.id })!
    }

    
    
    var body: some View {
        VStack {
            HStack{
                TextField(journal.name, text: $modelData.journals[index].name)
                    .font(.title)
                Spacer()
                Text(journal.date)
                    .font(.subheadline)
            }
            .padding()
            ScrollView{
                TextEditor(text: $modelData.journals[index].content)
                    
            }
        }
    }
}



struct JournalDetail_Previews: PreviewProvider {
    static var previews: some View {
        JournalDetail(journal: ModelData().journals[0])
            .environmentObject(ModelData())
    }
}
