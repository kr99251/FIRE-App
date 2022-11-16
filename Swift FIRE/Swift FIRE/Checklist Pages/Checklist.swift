//
//  ModuleObj.swift
//  Swift FIRETests
//
//  Created by Kelly Robinett on 10/26/22.
//

import Foundation
import SwiftUI
import CoreLocation

struct Checklist: Hashable, Codable, Identifiable {
    var id: Int
    var checklistName: String
    var sections: [[String]]
    var isChecked: [[Bool]]
}

