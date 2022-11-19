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
    var imageName : String?
}

struct ModuleDataSet : Codable{
    var modules : Array<ModuleData>
}
struct appState : Codable {
    var modNum : Int
    var pageNum : Int
    var increaseAmount : Int
    var modules = getModules()
    var currentModule : ModuleData
    var currentSection :  [String]
    var imageName : String?
    init(modNum : Int, pageNum : Int){
        self.modNum = modNum
        self.pageNum = pageNum
        self.increaseAmount = 10
        self.modules = getModules()
        self.currentModule = modules.modules[modNum]
        self.currentSection = currentModule.section[pageNum]
        self.imageName = currentModule.imageName
    }
    mutating func nextPage(){
        if pageNum < currentModule.pageMax - 1{
            pageNum += 1
            currentSection = currentModule.section[pageNum]
        }
    }
    mutating func prevPage(){
        if pageNum > 0{
            pageNum -= 1
            currentSection = currentModule.section[pageNum]
        }
    }
    mutating func setModule(modNum : Int){
        self.modNum = modNum
        self.currentModule = modules.modules[modNum]
        self.pageNum = 0
        self.currentSection = currentModule.section[pageNum]
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
    return nil
}

func getModules() -> ModuleDataSet{
    if let modules = loadJson(filename:"TestModule"){
        return modules
    }
    return ModuleDataSet(modules:[ModuleData(modId:-1, modName:"", pageMax: -1, section:[])])
}

func saveData(appData : appState){
    //Codable JSON Idea from
    //https://stackoverflow.com/questions/33186051/swift-convert-struct-to-json
    do {
        let jsonData = try JSONEncoder().encode(appData)
        if var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                url.appendPathComponent("appData.json")
                try jsonData.write(to: url)
                print("Saved")
            }
    } catch { print(error) }
}

func getStartupData() -> appState{
    let decoder = JSONDecoder()
    if let json = Bundle.main.url(forResource: "appData", withExtension: "json"){
        if let data = try?Data(contentsOf: json){
            if let appData = try?decoder.decode(appState.self, from: data){
                return appData
            }
        }
    }
    return appState(modNum: 0, pageNum:0)
}
