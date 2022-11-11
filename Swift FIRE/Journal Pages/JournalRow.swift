//
//  JournalRow.swift
//  Swift FIRE
//
//  Created by Noel Desmarais on 11/6/22.
//

import SwiftUI

struct JournalRow: View {
    var journal: Journal

    var body: some View {
        Text(journal.name)
        Spacer()
        Text(journal.date)
            .foregroundColor(.secondary)
        }
}

struct JournalRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            JournalRow(journal: journals[0])
            JournalRow(journal: journals[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
