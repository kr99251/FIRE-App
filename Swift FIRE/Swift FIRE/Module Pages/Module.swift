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
    let navy = Color(red: 0, green: 0, blue: 128/255)
    let blue = Color(red: 50/255, green: 150/255, blue: 255/255)
    @State var currentPage = 0
    @State var subPage = 1
    @State var surPage = 0
    @State var goToModuleView: Bool = false
    @State public var showPopUp: Bool = false
    @Binding var currentState: appState
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        let max = getMax(pg: module.section)
        var next = hasNext(max: max, current: currentPage) ? "Next": ""
        var prev = hasPrev(current: currentPage) ? "Prev": ""
        var done = isDone(max: max, current: currentPage) ? "Done": ""
        NavigationView {
            VStack{
                // Display header
                Text("\(module.section[surPage][0])")
                    .multilineTextAlignment(.center)
                    .font(.system(size: CGFloat(currentState.size + 5)) .bold())
                    .padding(5)
                    .foregroundColor(navy)
                    .offset(y: -5)
                    .minimumScaleFactor(0.01)
                // Picture and information
                ScrollView(showsIndicators: true) {
                    // Image
                    if let images = module.images{
                        if currentPage < images.count{
                            if let image = images[currentPage]{
                                Image(image)
                                    .resizable()
                                    .frame(width: 15*UIScreen.screenWidth/16, height: UIScreen.screenHeight/3)
                            }
                        }
                    }
                    // Information
                    Text("\(module.section[surPage][subPage])")
                        .font(.system(size: CGFloat(currentState.size)))
                }
                .padding([.leading, .trailing, .bottom], 20)
                
                // Next, previous, and done buttons
                HStack{
                    NavigationLink(destination: ModuleListView(currentState: $currentState).navigationBarHidden(true), isActive: $goToModuleView) {
                        EmptyView()
                    }
                    
                    // Finished with the module
                    Button("\(done)", action:{
                        done = "Done"
                        presentationMode.wrappedValue.dismiss()
                        currentState.moduleCompletionArray[module.modId - 1] = true
                        saveData(appData:currentState)
                        self.goToModuleView = true
                    })
                    .offset(x: 12*UIScreen.screenWidth/32, y: 5)
                    .font(.system(size: CGFloat(7*currentState.size/8)))
                    
                    Button("\(next)", action:{
                        prev = "Prev"
                        // Make sure there is another page
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
                    .font(.system(size: CGFloat(7*currentState.size/8)))
                    
                    Button("\(prev)", action:{
                        saveData(appData:currentState)
                        next = "Next"
                        // Make sure there is another page
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
                    .font(.system(size: CGFloat(7*currentState.size/8)))
                }.offset(y: -3*UIScreen.screenHeight/60)
                    .padding(10)
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(module: modules.modules[0], currentPage: 0, currentState: .constant(appState()))
    }
}

// Return the number of pages in the module
func getMax(pg: [[String]]) -> Int {
    var num_pgs = 0
    for c in pg {
        num_pgs += c.count - 1
    }
    return num_pgs
}

// See if there is another page
func hasNext(max: Int, current: Int) -> Bool {
    if (max > current + 1) {
        return true
    }
    return false
}

// See if there is a previous page
func hasPrev(current: Int) -> Bool {
    if (current > 0) {
        return true
    }
    return false
}

// See if the module is done
func isDone(max: Int, current: Int) -> Bool {
    if (current == max - 1) {
        return true
    }
    return false
}
