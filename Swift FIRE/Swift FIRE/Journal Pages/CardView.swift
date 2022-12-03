//
//  CardView.swift
//  Swift FIRE
//
//  Created by Noel Desmarais on 11/30/22.
//

import Foundation
import SwiftUI

struct CardView: View {
    let journal: JournalEntry
    @Binding var currentState: appState
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(journal.title)
                .font(.system(size: CGFloat(currentState.size)))
            Spacer()
            HStack {
                Label("\(journal.date)", systemImage: "calendar")
                Spacer()

            }
            .font(.system(size: CGFloat(currentState.size)))
        }
        .padding()
    }
}

struct CardView_Previews: PreviewProvider {
    static var journal = JournalEntry.sampleData[0]
    static var previews: some View {
        CardView(journal: journal, currentState: .constant(appState()))
            .previewLayout(.fixed(width: 400, height: 60))

    }
}
