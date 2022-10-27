//
//  ModuleRow.swift
//  Swift FIRE
//
//  Created by Kelly Robinett on 10/26/22.
//

import SwiftUI

struct ModuleRow: View {
    var moduleObj: ModuleObj
    
    var body: some View {
        HStack {
            Text("Module \(String(moduleObj.id)): \(moduleObj.modName)")
            Spacer()
        }
    }
}

struct ModuleRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ModuleRow(moduleObj: modules[0])
            ModuleRow(moduleObj: modules[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
