import Foundation
import SwiftUI

struct ModuleData : Codable {
    var modId : Int
    var modName : String
    var pageMax : Int
    var section : [[String]]
}

struct ModuleDataSet : Codable{
    var modules : Array<ModuleData>
}

var modNumber = 0

//Parse Json idea from https://stackoverflow.com/questions/24410881/reading-in-a-json-file-using-swift
func loadJson(filename: String) -> ModuleDataSet?{
    let decoder = JSONDecoder()
    if let json = Bundle.main.url(forResource: filename, withExtension: "json"){
        if let data = try?Data(contentsOf: json){
            if let modules = try?decoder.decode(ModuleDataSet.self, from: data){
                return modules
            }
        }
    }
    return nil
}
func getModules() -> ModuleDataSet{
    if let modules = loadJson(filename:"TestModule"){
        return modules
    }
    return ModuleDataSet(modules:[ModuleData(modId:-1, modName:"", pageMax: -1, section:[])])
}

struct ModuleListView: View {
    let modules = getModules()
    let navy = Color(red: 0, green: 0, blue: 128/255)
    let blue = Color(red: 50/255, green: 150/255, blue: 255/255)
    @Binding var currentState : appState
    @State var currentValue = 1
    @State var goToHomeView: Bool = false
    var body: some View {
        let v = modules.modules
        let startFont: CGFloat = 35
        NavigationView {
            VStack(alignment: .center) {
                NavigationLink(destination: Main().navigationBarHidden(true), isActive: $goToHomeView) {
                    EmptyView()
                }
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
                    Button(action: {currentState.increaseAmount += 5; if currentState.increaseAmount > 50{ currentState.increaseAmount = 0}}) {
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
                NavigationView {
                    VStack {
                        Text("Modules")
                            .font(.largeTitle .bold())
                            .padding([.leading, .trailing, .top], 10)
                            .foregroundColor(Color.white)
                            .offset(y: -10)
                        List(0..<v.count, id: \.self) { num in
                            NavigationLink(v[num].modName, destination: ContentView(module: v[num]))
                                .padding([.top, .bottom], 20)
                        }
                        .listStyle(.insetGrouped)
                        .background(navy)
                        .font(.system(size: startFont + CGFloat(currentState.increaseAmount)))
                        .foregroundColor(navy)
                    }.background(blue)
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
        let cState = appState(modNum:0, pageNum:0)
        ModuleListView(currentState: .constant(cState))
    }
}
