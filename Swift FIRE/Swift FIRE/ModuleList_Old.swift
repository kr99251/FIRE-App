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

struct ModuleList: View {
    var body: some View {
        Text("Hello")
    }
}


struct Previews_ModuleList_Previews: PreviewProvider {
    static var previews: some View {
        ModuleList()
    }
}
