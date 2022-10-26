//
//  ContentView.swift
//  Swift FIRE
//
//  Created by Kelly Robinett on 10/26/22.
//

import SwiftUI
var modules = getModules()
struct ContentView: View {
    @State var currentValue = 0
    var body: some View {
        VStack(spacing: 20) {
            Text("value is \(currentValue)")
            Button("Increment", action: { currentValue += 1 } )
            // can also put the action closure outside
            Button("Decrement") {currentValue -= 1 }
            
            Button (modules.modules[currentValue].modName, action:{})
                .offset(x:50)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
