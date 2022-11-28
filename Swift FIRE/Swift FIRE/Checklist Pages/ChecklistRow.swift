//
//  ChecklistRow.swift
//  Swift FIRE
//
//  Created by Kelly Robinett on 10/26/22.
//

import SwiftUI

struct ChecklistRow: View {
    @EnvironmentObject var modelData: ModelData
    
    var checklistIndex: Int {
        modelData.checklists.firstIndex(where: { $0.id == checklist.id })!
    }
    
    @State var checklist: Checklist
    var sectionNum: Int
    var rowNum: Int
    var blue = Color(red: 0, green: 165/255, blue: 224/255)
    var navy = Color(red: 0, green: 0, blue: 128/255)

    var body: some View {
        HStack {
            // checklist row info
            Text(checklist.sections[sectionNum][rowNum])
            Spacer()
            // checkmark button
            CheckmarkButton(isChecked: $modelData.checklists[checklistIndex].isChecked[sectionNum][rowNum])
        }
        .padding()
    }
}

struct ChecklistRow_Previews: PreviewProvider {
    static let modelData = ModelData()
    
    static var checklists = modelData.checklists
    static var previews: some View {
        ChecklistRow(checklist: checklists[0], sectionNum: 1, rowNum: 1)
            .environmentObject(modelData)
    }
}
