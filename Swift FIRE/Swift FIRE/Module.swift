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
    var module: ModuleData
    @State var currentPage = 0
//    @Binding var currentState : appState
//    var body: some View {
//        VStack{
//            Text(currentState.currentPage)
//                .font(.system(size : CGFloat(5 + currentState.increaseAmount)))
//                .frame(height: 4*UIScreen.screenHeight / 9)
//            HStack{
//                Button("Next", action:{currentState.nextPage()})
//                    .offset(x: 15*UIScreen.screenWidth/32)
//                Button("Prev", action:{currentState.prevPage()})
//                    .offset(x: -15*UIScreen.screenWidth/32)
//            }
//        }
//    }
    var body: some View {
        var next = hasNext(max: module.pageMax, current: currentPage) ? "Next": ""
        var prev = hasPrev(current: currentPage) ? "Prev": ""
        VStack{
            Text(module.pages[currentPage])
                .font(.title2)
                .frame(height: 4*UIScreen.screenHeight / 9).padding(10)
            HStack{
                Button("\(next)", action:{
                    prev = "Prev"
                    currentPage += 1
                })
                    .offset(x: 12*UIScreen.screenWidth/32)
                Button("\(prev)", action:{
                    next = "Next"
                    currentPage -= 1
                })
                    .offset(x: -12*UIScreen.screenWidth/32)
            }
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        let cState = appState(modNum:0, pageNum:0)
//        ContentView(currentState : .constant(cState))
        ContentView(module: modules.modules[0])
    }
}

//func initNext()

func hasNext(max: Int, current: Int) -> Bool {
    if (max > current + 1) {
        return true
    }
    return false
}

func hasPrev(current: Int) -> Bool {
    if (current > 0) {
        return true
    }
    return false
}
