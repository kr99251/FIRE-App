//
//  ContentView.swift
//  Swift FIRE
//
//  Created by Kelly Robinett on 10/26/22.
//

import SwiftUI
var modules = getModules()
var currentModule = modules.modules[0]
struct ContentView: View {
    @State var pageNum = 0
    //@Binding var increaseAmount : Int
    var increaseAmount = 10
    var body: some View {
        VStack{
            HStack{
                Button("Next", action:{nextPage()})
                    .offset(x:110)
                    .offset(y:240)
                Button("Prev", action:{prevPage()})
                    .offset(x:-110)
                    .offset(y:240)
            }
            Text(currentModule.pages[pageNum])
                .font(.system(size : CGFloat(25 + increaseAmount)))
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
