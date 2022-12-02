//
//  JournalStore.swift
//  Swift FIRE
//
//  Created by Noel Desmarais on 11/30/22.
//

import Foundation
import SwiftUI

class JournalStore: ObservableObject{
    @Published var journals: [JournalEntry] = []
    
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false)
            .appendingPathComponent("journals.data")
    }
    
    static func load(completion: @escaping (Swift.Result<[JournalEntry], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let journals = try JSONDecoder().decode([JournalEntry].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(journals))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func save(journals: [JournalEntry], completion: @escaping (Swift.Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(journals)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(journals.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
