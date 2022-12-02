//
//  AppData.swift
//  Swift FIRE
//
//  Created by Noah on 11/16/22.
//
import Foundation
import SwiftUI
// Idea from https://stackoverflow.com/questions/57727107/how-to-get-the-iphones-screen-width-in-swiftui
extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}
struct ModuleData : Codable {
    var modId : Int
    var modName : String
    var pageMax : Int
    var section : [[String]]
    var images : Array<String?>?
}

struct ModuleDataSet : Codable{
    var modules : Array<ModuleData>
}
struct appState : Codable {
    var modules = getModules()
    var moduleCompletionArray : Array<Bool>
    var checklistCompletionArray : Array<Bool>
    var size : Double
    init(){
        self.modules = getModules()
        self.moduleCompletionArray = Array<Bool>(repeating: false, count:modules.modules.count)
        self.checklistCompletionArray = Array<Bool>(repeating: false, count:modules.modules.count)
        self.size = 25.0
    }
}

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
    print("failed to get data from json")
    return nil
}
func getModules() -> ModuleDataSet{
    if var modules = loadJson(filename:"Modules"){
        for imod in 0 ... modules.modules.count - 1{
            if let images = modules.modules[imod].images{
                modules.modules[imod].images = images.map({$0 == String?("nil") ? nil : $0})
            }
        }
        return modules
    }
    return ModuleDataSet(modules:[ModuleData(modId:-1, modName:"", pageMax: -1, section:[], images: [""])])
}
//Idea from https://www.hackingwithswift.com/example-code/strings/how-to-save-a-string-to-a-file-on-disk-with-writeto
func getDocumentsDirectory() -> URL{
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}
func saveData(appData : appState){
    let encoder = JSONEncoder()
    do {
        let jsonString = try encoder.encode(appData)
        let filename = getDocumentsDirectory().appendingPathComponent("appData.json")
        try jsonString.write(to: filename)
    }
    catch{
        print("unable to encode app data to json format")
    }
}

func getStartupData() -> appState{
    let decoder = JSONDecoder()
    let json = getDocumentsDirectory().appendingPathComponent("appData.json")
    let useStoredData : Bool = true
    if (useStoredData){
        if let data = try?Data(contentsOf: json){
            if let appData = try?decoder.decode(appState.self, from: data){
                return appData
            }
        }
    }
    return appState()
}
