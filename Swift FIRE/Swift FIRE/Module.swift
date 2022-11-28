//
//  ContentView.swift
//  Swift FIRE
//
//  Created by Kelly Robinett on 10/26/22.
//

import SwiftUI
var modules = getModules()

struct ContentView: View {
    var module: ModuleData
    var size: Double
    let navy = Color(red: 0, green: 0, blue: 128/255)
    let blue = Color(red: 50/255, green: 150/255, blue: 255/255)
    @State var currentPage = 0
    @State var subPage = 1
    @State var surPage = 0
    @State var currentState = appState(modNum:0, pageNum:0)
    @State var goToModuleView: Bool = false
    @State public var showPopUp: Bool = false
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        let max = getMax(pg: module.section)
        var next = hasNext(max: max, current: currentPage) ? "Next": ""
        var prev = hasPrev(current: currentPage) ? "Prev": ""
        var done = isDone(max: max, current: currentPage) ? "Done": ""
        //var vertOffset = 0
        NavigationView {
            VStack{
                Text("\(module.section[surPage][0])")
                    .multilineTextAlignment(.center)
                    .font(.system(size: CGFloat(size + 10)) .bold())
                    //.frame(height: 4*UIScreen.screenHeight / 15)
                    .padding([.leading, .trailing, .top], 5)
                    .foregroundColor(navy)
                    .offset(y: -5)
                if let imageName = currentState.imageName{
                    Image(imageName)
                }
                ScrollView(showsIndicators: true) {
                    Text("\(module.section[surPage][subPage])")
                        .font(.system(size: CGFloat(size)))
                    
                }
                // .frame(height: 4*UIScreen.main.bounds.height / 10)
                    .padding([.leading, .trailing, .bottom], 20)
                HStack{
                    NavigationLink(destination: ModuleListView(currentState:$currentState, size: size).navigationBarHidden(true), isActive: $goToModuleView) {
                        EmptyView()
                    }
                    
                    Button("\(done)", action:{
                        saveData(appData:currentState)
                        done = "Done"
                        presentationMode.wrappedValue.dismiss()
                        self.goToModuleView = true
                    })
                    .offset(x: 12*UIScreen.screenWidth/32, y: 5)
                    .font(.system(size: CGFloat(7*size/8)))
                    
                    Button("\(next)", action:{
                        saveData(appData:currentState)
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
                    .offset(x: 12*UIScreen.screenWidth/32, y: 5)
                    .font(.system(size: CGFloat(7*size/8)))
                    
                    Button("\(prev)", action:{
                        saveData(appData:currentState)
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
                    .offset(x: -12*UIScreen.screenWidth/32, y: 5)
                    .font(.system(size: CGFloat(7*size/8)))
                }.offset(y: -3*UIScreen.screenHeight/60)
                    // .frame(height: 4*UIScreen.screenHeight/30)
                    .padding(10)
            }
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // let cState = appState(modNum:0, pageNum:0)
        // ContentView(currentState : .constant(cState))
        ContentView(module: modules.modules[0], size: 20.0)
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
