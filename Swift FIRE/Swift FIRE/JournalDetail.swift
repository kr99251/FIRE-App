//
//  JournalDetail.swift
//  Swift FIRE
//
//  Created by Noel Desmarais on 11/9/22.
//

import SwiftUI

struct JournalDetail: View {
    @EnvironmentObject var modelData: ModelData

    var journal: Journal
    
    var journalIndex: Int {
        modelData.journals.firstIndex(where: { $0.id == journal.id })!
    }
    
    var body: some View {
        VStack {
            HStack{
                Text(journal.name)
                    .font(.title)
                Spacer()
                Text(journal.date)
                    .font(.subheadline)
            }
            .padding()
            ScrollView{
                Text(journal.content)
                    .padding()
            }
        }
        
    }
}


struct JournalDetail_Previews: PreviewProvider {
    static var previews: some View {
        JournalDetail(journal: ModelData().journals[0])
    }
}
