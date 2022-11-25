//
//  JournalRow.swift
//  Swift FIRE
//
//  Created by Noel Desmarais on 11/6/22.
//
import SwiftUI

struct JournalRow: View {
    @EnvironmentObject var modelData: ModelData
    @State var journal: Journal

    var index: Int {
        modelData.journals.firstIndex(where: { $0.id == journal.id })!
    }
    
    var body: some View {
        Text(modelData.journals[index].name)
        Spacer()
        Text(modelData.journals[index].date)
            .foregroundColor(.secondary)
        }
}

struct JournalRow_Previews: PreviewProvider {
    static let modelData = ModelData()

    static var previews: some View {
        Group {
            JournalRow(journal: modelData.journals[0])
            JournalRow(journal: modelData.journals[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
        .environmentObject(modelData)
    }
}
