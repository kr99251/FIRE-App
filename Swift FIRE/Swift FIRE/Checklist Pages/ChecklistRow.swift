//
//  ChecklistRow.swift
//  Swift FIRE
//
//  Created by Kelly Robinett on 10/26/22.
//

import SwiftUI

struct ChecklistRow: View {
    @State var checklist: Checklist
    var sectionNum: Int
    var rowNum: Int
    var blue = Color(red: 0, green: 165/255, blue: 224/255)
    var navy = Color(red: 0, green: 0, blue: 128/255)

    var body: some View {
        HStack {
            Text(checklist.sections[sectionNum][rowNum])
            Spacer()
            if checklist.isChecked[sectionNum][rowNum] {
              Text("✅")
            } else {
              Text("🔲")
            }
        }
        .padding()
        .onTapGesture(count: 1, perform: {checklist.isChecked[sectionNum][rowNum] = !checklist.isChecked[sectionNum][rowNum]})
    }
}

struct ChecklistRow_Previews: PreviewProvider {
    static var checklists = ModelData().checklists
    static var previews: some View {
        Group {
            ChecklistRow(checklist: checklists[0], sectionNum: 1, rowNum: 1)
            ChecklistRow(checklist: checklists[1], sectionNum: 0, rowNum: 1)
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
