//
//  ContentView.swift
//  Swift FIRE
//
//  Created by Kelly Robinett on 10/26/22.
//

import SwiftUI
var modules = getModules()
// Idea from https://stackoverflow.com/questions/57727107/how-to-get-the-iphones-screen-width-in-swiftui
extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
struct ContentView: View {
    @Binding var currentState : appState
    var body: some View {
        VStack{
            Text(currentState.currentPage)
                .font(.system(size : CGFloat(5 + currentState.increaseAmount)))
                .frame(height: 4*UIScreen.screenHeight / 9)
            HStack{
                Button("Next", action:{currentState.nextPage()})
                    .offset(x: 15*UIScreen.screenWidth/32)
                Button("Prev", action:{currentState.prevPage()})
                    .offset(x: -15*UIScreen.screenWidth/32)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let cState = appState(modNum:0, pageNum:0)
        ContentView(currentState : .constant(cState))
    }
}
