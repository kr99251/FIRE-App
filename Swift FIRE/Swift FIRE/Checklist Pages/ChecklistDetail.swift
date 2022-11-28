//
//  ChecklistDetail.swift
//  Swift FIRE
//
//  Created by Kelly Robinett on 11/8/22.
//

import SwiftUI

struct ChecklistDetail: View {
    @State var checklist: Checklist
    
    var body: some View {
        // List of all the checklist items
        List(0..<checklist.sections.count, id: \.self) { sectionNum in
            // Display the heading for each section of the checklist
            Text("\(checklist.sections[sectionNum][0])")
            if (checklist.sections[sectionNum].count > 1) {
                // Display the content of each section
                ForEach(1..<checklist.sections[sectionNum].count-1) { rowNum in
                    ChecklistRow(checklist: checklist, sectionNum: sectionNum, rowNum: rowNum)
                }
            }
        }
        .navigationTitle(checklist.checklistName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChecklistDetail_Previews: PreviewProvider {
    static var previews: some View {
        ChecklistDetail(checklist: ModelData().checklists[0])
            .environmentObject(ModelData())
    }
}


