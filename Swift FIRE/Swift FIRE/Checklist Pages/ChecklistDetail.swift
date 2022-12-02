//
//  ChecklistDetail.swift
//  Swift FIRE
//
//  Created by Kelly Robinett on 11/8/22.
//

import SwiftUI

struct ChecklistDetail: View {
    @State var checklist: Checklist
    var size: Double
    let navy = Color(red: 0, green: 0, blue: 128/255)
    
    var body: some View {
        VStack {
            // Display header
            Text(checklist.checklistName)
                .multilineTextAlignment(.center)
                .font(.system(size: CGFloat(size + 10)) .bold())
                .padding(5)
                .foregroundColor(navy)
                .offset(y: -5)
                .minimumScaleFactor(0.01)
            // List of all the checklist items
            List(0..<checklist.sections.count, id: \.self) { sectionNum in
                // Display the heading for each section of the checklist
                Text("\(checklist.sections[sectionNum][0])").font(.system(size: CGFloat(size + 5)) .bold()).minimumScaleFactor(0.01)
                if (checklist.sections[sectionNum].count > 1) {
                    // Display the content of each section
                    ForEach(1..<checklist.sections[sectionNum].count-1) { rowNum in
                        ChecklistRow(checklist: checklist, sectionNum: sectionNum, rowNum: rowNum).font(.system(size: CGFloat(size)))
                    }
                }
            }
        }
//        .navigationBarHidden(true)
        .navigationTitle("")
//        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChecklistDetail_Previews: PreviewProvider {
    static var previews: some View {
        ChecklistDetail(checklist: ModelData().checklists[0], size: 25.0)
            .environmentObject(ModelData())
    }
}


