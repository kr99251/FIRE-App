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
    let navy = Color(red: 0, green: 0, blue: 128/255)
    let blue = Color(red: 50/255, green: 150/255, blue: 255/255)
    @State var currentPage = 0
    @State var subPage = 1
    @State var surPage = 0
    @State var currentState = appState(modNum:0, pageNum:0)
    @State var goToModuleView: Bool = false
    @Environment(\.presentationMode) var presentationMode
    // @Binding var currentState : appState
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
        let max = getMax(pg: module.section)
        var next = hasNext(max: max, current: currentPage) ? "Next": ""
        var prev = hasPrev(current: currentPage) ? "Prev": ""
        var done = isDone(max: max, current: currentPage) ? "Done": ""
        NavigationView {
            VStack{
                Text("\(module.section[surPage][0])")
                    .multilineTextAlignment(.center)
                    .font(.title .bold())
                    .frame(height: 4*UIScreen.screenHeight / 15)
                    .padding([.leading, .trailing, .top], 5)
                    .foregroundColor(navy)
                    .offset(y: -5)
                ScrollView(showsIndicators: true) {
                    Text("\(module.section[surPage][subPage])")
                        .font(.title2)
                    
                }.frame(height: 4*UIScreen.main.bounds.height / 10).padding([.leading, .trailing, .bottom], 20)
                HStack{
                    NavigationLink(destination: ModuleListView(currentState:$currentState).navigationBarHidden(true), isActive: $goToModuleView) {
                        EmptyView()
                    }
                    
                    Button("\(done)", action:{
                        done = "Done"
                        presentationMode.wrappedValue.dismiss()
                        self.goToModuleView = true
                    })
                    .offset(x: 12*UIScreen.screenWidth/32)
                    
                    Button("\(next)", action:{
                        prev = "Prev"
                        if (surPage < max) {
                            currentPage += 1
                            if (subPage == module.section[surPage].count - 1) {
                                subPage = 1
                                surPage += 1
                            } else {
                                subPage += 1
                            }
                        } else {
                            if (subPage < module.section[surPage].count - 1) {
                                subPage += 1
                            }
                        }
                    })
                    .offset(x: 12*UIScreen.screenWidth/32)
                    
                    Button("\(prev)", action:{
                        next = "Next"
                        currentPage -= 1
                        if (surPage > 0) {
                            if (subPage == 1) {
                                surPage -= 1
                                subPage = module.section[surPage].count - 1
                            } else {
                                subPage -= 1
                            }
                        } else {
                            if (subPage > 1) {
                                subPage -= 1
                            }
                        }
                    })
                    .offset(x: -12*UIScreen.screenWidth/32)
                }.offset(y: -3*UIScreen.screenHeight/60)
                    .frame(height: 4*UIScreen.screenHeight/30)
                    .padding(10)
            }
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // let cState = appState(modNum:0, pageNum:0)
        // ContentView(currentState : .constant(cState))
        ContentView(module: modules.modules[0])
    }
}

func getMax(pg: [[String]]) -> Int {
    var num_pgs = 0
    for c in pg {
        num_pgs += c.count - 1
    }
    return num_pgs
}

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

func isDone(max: Int, current: Int) -> Bool {
    if (current == max - 1) {
        return true
    }
    return false
}
