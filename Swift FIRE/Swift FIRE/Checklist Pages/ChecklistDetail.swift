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
            List(0..<checklist.items.count, id: \.self) { num in
                ChecklistRow(checklist: checklist, num: num)
//                .onTapGesture(count: 1, perform: {checklist.isChecked[num] = !checklist.isChecked[num]})
            }
            .navigationBarTitle("\(checklist.checklistName)")
        }
    }
}

struct ChecklistDetail_Previews: PreviewProvider {
    static var previews: some View {
        ChecklistDetail(checklist: checklists[0])
    }
}


