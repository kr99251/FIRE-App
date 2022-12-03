//
//  JournalEntry.swift
//  Swift FIRE
//
//  Created by Noel Desmarais on 11/30/22.
//

import Foundation

struct JournalEntry: Codable, Identifiable, Equatable{
    var id: UUID = UUID()
    var title: String = ""
    var date: String = ""
    var content: String = ""
        
    init(id: UUID = UUID(), title: String, date: String, content: String) {
        self.id = id
        self.title = title
        self.date = date
        self.content = content
    }
    init(journal: JournalEntry) {
        self.id = journal.id
        self.title = journal.title
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        self.date = dateFormatter.string(from: date)
        self.content = journal.content
    }
    init() {
        self.id = UUID()
        self.title = ""
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        self.date = dateFormatter.string(from: date)
        self.content = ""
    }
}

extension JournalEntry{
    static let sampleData: [JournalEntry] =
    [
        JournalEntry(title: "I fell", date: "January 1, 2022", content: "Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentum sagittis vivamus, cras ante etiam sit conubia elit tempus accumsan libero, mattis per erat habitasse cubilia ligula penatibus curae. Sagittis lorem augue arcu blandit libero"),
        JournalEntry(title: "I'm falling", date: "February 1, 2022", content: "Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentum sagittis vivamus, cras ante etiam sit conubia elit tempus accumsan libero, mattis per erat habitasse cubilia ligula penatibus curae. Sagittis lorem augue arcu blandit libero"),
        JournalEntry(title: "I will fall", date: "May 1, 2022", content: "Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentum sagittis vivamus, cras ante etiam sit conubia elit tempus accumsan libero, mattis per erat habitasse cubilia ligula penatibus curae. Sagittis lorem augue arcu blandit libero")
    ]
}


