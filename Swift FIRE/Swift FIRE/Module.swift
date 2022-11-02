//
//  ContentView.swift
//  Swift FIRE
//
//  Created by Kelly Robinett on 10/26/22.
//

import SwiftUI
var modules = getModules()
var currentModule = modules.modules[0]
// Idea from https://stackoverflow.com/questions/57727107/how-to-get-the-iphones-screen-width-in-swiftui
extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
struct ContentView: View {
    @State var pageNum = 0
    //@Binding var increaseAmount : Int
    var increaseAmount = 10
    var body: some View {
        VStack{
            Text(currentModule.pages[pageNum])
                .font(.system(size : CGFloat(5 + increaseAmount)))
                .frame(height: 4*UIScreen.screenHeight / 9)
            HStack{
                Button("Next", action:{nextPage()})
                    .offset(x: 15*UIScreen.screenWidth/32)
                Button("Prev", action:{prevPage()})
                    .offset(x: -15*UIScreen.screenWidth/32)
            }
        }
    }
    func nextPage(){
        if pageNum < currentModule.pageMax - 1{
            pageNum += 1
        }
    }
    func prevPage(){
        if pageNum > 0{
            pageNum -= 1
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
