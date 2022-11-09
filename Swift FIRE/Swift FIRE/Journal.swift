//
//  Journal.swift
//  Swift FIRE
//
//  Created by Noel Desmarais on 11/6/22.
//

import Foundation
import SwiftUI

struct Journal: Codable, Hashable, Identifiable{
    var id: Int
    var name: String
    var date: String
    var content: String
    
}
