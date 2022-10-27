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
    var modules = getModules()

    @State var currentValue = 1

    
        var body: some View {
            let v = modules.modules
            NavigationView {
                VStack(alignment: .center) {
                    Text("Modules").font(.largeTitle).padding([.bottom, .trailing, .leading], 20)
                    VStack() {
                        ScrollView(.vertical, showsIndicators: true) {
                            ForEach(0..<v.count, id: \.self) {
                                number in
                                NavigationLink(v[number].modName, destination: ContentView())
                                    .frame(width: 295, height: 40)
                                    .padding(20)
                                    .font(.largeTitle)
                                    .foregroundColor(Color.white)
                                    .background(Color.blue)
                                    .cornerRadius(20)
                            }
                        }.padding([.top, .trailing, .leading], 10)
                    }
                    .frame(width: 350, height: 500)
                    .background(Color(.systemGray4))

                }
            }
    }
}



struct ModuleListView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleListView()
    }
}
