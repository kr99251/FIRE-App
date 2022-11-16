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
        NavigationView {
            List(0..<checklist.sections.count, id: \.self) { sectionNum in
                Text("\(checklist.sections[sectionNum][0])")
                if (checklist.sections[sectionNum].count > 1) {
                    ForEach(1..<checklist.sections[sectionNum].count-1) { rowNum in
                        ChecklistRow(checklist: checklist, sectionNum: sectionNum, rowNum: rowNum)
                    }
                }
                
            }
//            .navigationBarTitle("\(checklist.checklistcName)")
        }
    }
}

struct ChecklistDetail_Previews: PreviewProvider {
    static var previews: some View {
        ChecklistDetail(checklist: ModelData().checklists[1])
    }
}


