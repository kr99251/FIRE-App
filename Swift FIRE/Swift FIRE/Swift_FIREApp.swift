//
//  Swift_FIREApp.swift
//  Swift FIRE
//
//  Created by Kelly Robinett on 10/26/22.
//

import SwiftUI

@main
struct Swift_FIREApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            Main()
                .environmentObject(modelData)
        }
    }
}
