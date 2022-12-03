//
//  ModelData.swift
//  Swift FIRE
//
//  Created by Noel Desmarais on 11/6/22.
//

import Foundation
import Combine
import SwiftUI

//code adapted from https://developer.apple.com/tutorials/swiftui/handling-user-input

final class ModelData: ObservableObject{
    @Published var checklists: [Checklist] = getChecklistData()
    var quizzes: [Quiz] = load("Quizzes.json")
}


func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

func saveChecklists(checklists: [Checklist]){
    let encoder = JSONEncoder()
    do {
        let jsonString = try encoder.encode(checklists)
        let filename = getDocumentsDirectory().appendingPathComponent("ChecklistsData.json")
        try jsonString.write(to: filename)
    }
    catch{
        print("unable to encode checklists to json format")
    }
}
func getChecklistData() -> [Checklist]{
    let decoder = JSONDecoder()
    let json = getDocumentsDirectory().appendingPathComponent("ChecklistsData.json")
    let useStoredData : Bool = true
    if (useStoredData){
        if let data = try?Data(contentsOf: json){
            if let checklists = try?decoder.decode([Checklist].self, from: data){
                return checklists
            }
        }
    }
    return load("Checklists.json")
}
