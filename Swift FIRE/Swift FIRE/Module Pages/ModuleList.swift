import Foundation
import SwiftUI

var modNumber = 0

struct ModuleListView: View {
    let modules = getModules()
    let navy = Color(red: 0, green: 0, blue: 128/255)
    let blue = Color(red: 50/255, green: 150/255, blue: 255/255)
    let gray = Color(red: 105/255, green: 105/255, blue: 105/255)
    @Binding var currentState : appState
    @State var goToHomeView: Bool = false
    @State private var showPopUp: Bool = false
    
    var body: some View {
        let v = modules.modules
        NavigationView {
            VStack(alignment: .center) {
                NavigationLink(destination: Main(currentState : $currentState).navigationBarHidden(true), isActive: $goToHomeView) {
                    EmptyView()
                }
                // Menu and font options
                HStack {
                    Button(action: {self.goToHomeView = true}) {
                        Text("Home")
                            .frame(width: 80.0, height: 50)
                            .foregroundColor(Color.white)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 3)
                    )
                    Spacer()
                    Button(action: {showPopUp = true}) {
                        Text("Font Size")
                            .frame(width: 80.0, height: 50)
                            .foregroundColor(Color.white)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 3)
                    )
                }
                .foregroundColor(Color.white)
                .padding(20)
                
                // Module list
                ZStack {
                    NavigationView {
                        VStack {
                            Text("Modules")
                                .font(.system(size: CGFloat(currentState.size + 10)) .bold())
                                .padding([.leading, .trailing, .top], 10)
                                .foregroundColor(Color.white)
                                .offset(y: -10)
                            // Print the modules
                            List(0..<v.count, id: \.self) { num in
                                NavigationLink { ContentView(module: v[num], currentState: $currentState) } label: {
                                    HStack {
                                        Text("\(v[num].modName)")
                                            .foregroundColor( currentState.moduleCompletionArray[num] == false ? navy : gray)
                                            .font(.system(size: CGFloat(currentState.size)))
                                    }
                                }
                                .padding([.top, .bottom], 20)
                            }
                            .listStyle(.insetGrouped)
                            .background(navy)
                        }
                        .background(blue)
                        .navigationTitle("")
                        .navigationBarHidden(true)
                    }
                    // Pop up for the font
                    PopUpWindow(message: "Choose a font size:", buttonText: "Done", show: $showPopUp, currentState: $currentState)
                }
                }
                .background(blue)
                .navigationTitle("")
                .navigationBarHidden(true)
        }
    }
}

struct ModuleListView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleListView(currentState: .constant(appState()))
    }
}
