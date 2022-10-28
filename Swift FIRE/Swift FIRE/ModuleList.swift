import Foundation
import SwiftUI

struct ModuleData : Codable{
    var modId : Int
    var modName : String
    var pageMax : Int
    var pages : Array<String>
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
    return ModuleDataSet(modules:[ModuleData(modId:-1, modName:"", pageMax:-1, pages:[])])
}

struct ModuleListView: View {
    let modules = getModules()
    let navy = Color(red: 0, green: 0, blue: 128/255)
    @State var currentValue = 1
    @State var goToHomeView: Bool = false
    
    var body: some View {
        let v = modules.modules
        
        NavigationView {
            VStack(alignment: .center) {
                NavigationLink(destination: Main().navigationBarHidden(true), isActive: $goToHomeView) {
                    EmptyView()
                }
                HStack {
                    Button(action: {self.goToHomeView = true}) {
                        Text("Home")
                            .frame(width: 80.0, height: 50)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(navy, lineWidth: 3)
                    )
                    Spacer()
                    Button(action: {}) {
                        Text("Font Size")
                            .frame(width: 80.0, height: 50)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(navy, lineWidth: 3)
                    )
                }
                .foregroundColor(navy)
                .padding()
                Text("Modules")
                    .font(.largeTitle .bold())
                    .padding(20)
                    .foregroundColor(navy)
                    .offset(y: -50)
                
                NavigationView {
                    List(0..<v.count, id: \.self) { num in
                        NavigationLink(v[num].modName, destination: ContentView())
                            .padding(30)
                    }
                    .listStyle(.insetGrouped)
                    .background(navy)
                    .font(.largeTitle)
                    .foregroundColor(navy)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct ModuleListView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleListView()
    }
}
