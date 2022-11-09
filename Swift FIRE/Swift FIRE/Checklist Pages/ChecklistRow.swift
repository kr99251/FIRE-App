//
//  ChecklistRow.swift
//  Swift FIRE
//
//  Created by Kelly Robinett on 10/26/22.
//

import SwiftUI

struct ChecklistRow: View {
    @State var checklist: Checklist
    var num: Int
    var blue = Color(red: 0, green: 165/255, blue: 224/255)
    var navy = Color(red: 0, green: 0, blue: 128/255)

    var body: some View {
        HStack {
            Text(checklist.items[num])
            Spacer()
            if checklist.isChecked[num] {
              Text("✅")
            } else {
              Text("🔲")
            }
        }
        .padding()
        .onTapGesture(count: 1, perform: {checklist.isChecked[num] = !checklist.isChecked[num]})
    }
}

struct ChecklistRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ChecklistRow(checklist: checklists[0], num: 0)
            ChecklistRow(checklist: checklists[0], num: 1)
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}

func editJson() {
    
}
