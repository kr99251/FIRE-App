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
    @State var currentState : appState = getStartupData()
    var body: some Scene {
        WindowGroup {
            Main(currentState: $currentState)
                .environmentObject(modelData)
        }
    }
}
