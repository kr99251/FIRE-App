//
//  ModuleList.swift
//  Swift FIRE
//
//  Created by Kelly Robinett on 10/27/22.
//

import SwiftUI

struct ModuleList: View {
    var body: some View {
        NavigationView {
            List(modules) { moduleObj in
                NavigationLink {
                    Main()
                } label: {
                    ModuleRow(moduleObj: moduleObj)
                }
            }
            .navigationTitle("Modules")
        }
    }
}

struct ModuleList_Previews: PreviewProvider {
    static var previews: some View {
        ModuleList()
    }
}
