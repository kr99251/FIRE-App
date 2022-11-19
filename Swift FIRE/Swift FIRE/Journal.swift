//
//  Journal.swift
//  Swift FIRE
//
//  Created by Noel Desmarais on 11/6/22.
//

import Foundation
import SwiftUI

struct Journal: Codable, Hashable, Identifiable{
    var id: Int = 0
    var name: String = ""
    var date: String = ""
    var content: String = ""
}

extension Journal{
    struct Journal{
        var id: Int = 0
        var name: String = ""
        var date: String = ""
        var content: String = ""
    }

    var journal: Journal{
        Journal(id: id, name: name, date: date, content: content)
    }
}
