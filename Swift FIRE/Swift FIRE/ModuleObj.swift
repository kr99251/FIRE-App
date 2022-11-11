//
//  ModuleObj.swift
//  Swift FIRETests
//
//  Created by Kelly Robinett on 10/26/22.
//

import Foundation
import SwiftUI
import CoreLocation

struct ModuleObj: Hashable, Codable, Identifiable {
    var id: Int
    var modName: String
    var pageMax: Int
    var pages: [String]
}
