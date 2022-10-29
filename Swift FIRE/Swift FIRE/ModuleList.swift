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
    let blue = Color(red: 0, green: 0, blue: 255/255)
    @State var increaseAmount: Int = 0
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
                            .background(navy)
                            .foregroundColor(Color.white)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 3)
                    )
                    Spacer()
                    Button(action: {increaseAmount += 5}) {
                        Text("Font Size")
                            .frame(width: 80.0, height: 50)
                            .foregroundColor(Color.white)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 3)
                    )
                }
                .foregroundColor(navy)
                .padding(20)
                Text("Modules")
                    .font(.largeTitle .bold())
                    .padding([.leading, .trailing, .top], 10)
                    .foregroundColor(Color.white)
                    .offset(y: -10)
                NavigationView {
                    List(0..<v.count, id: \.self) { num in
                        NavigationLink(v[num].modName, destination: ContentView())
                            .padding(25)
                    }
                    .listStyle(.insetGrouped)
                    .background(navy)
                    .font(.system(size: startFont + CGFloat(increaseAmount)))
                    .foregroundColor(navy)
                }
            }
            .background(navy)
            .navigationBarHidden(true)
        }
    }
}

struct ModuleListView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleListView()
    }
}
