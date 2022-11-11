//
//  ModelData.swift
//  Swift FIRE
//
//  Created by Noel Desmarais on 11/6/22.
//

import Foundation
import Combine

//code adapted from https://developer.apple.com/tutorials/swiftui/handling-user-input

final class ModelData: ObservableObject{
    @Published var journals: [Journal] = load("JournalContent.json")
}

var journals: [Journal] = load("JournalContent.json")

var checklists: [Checklist] = load("Checklists.json")

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
