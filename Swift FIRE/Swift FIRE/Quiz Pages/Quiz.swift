//
//  Quiz.swift
//  Swift FIRE
//
//  Created by Kelly Robinett on 11/20/22.
//

import Foundation
import SwiftUI
import CoreLocation

struct Quiz: Hashable, Codable, Identifiable {
    var id: Int
    var quizName: String
    var questions: [String]
//    var answers: [[String]]
//    var points: [[Int]]
//    var results: [[String]]
    var answers: [[Answer]]
    var results: [Result]
}

struct Answer: Hashable, Codable {
    var answer: String
    var points: Int
}

struct Result: Hashable, Codable {
    var result: String
    var description: String
    var pointMin: Int
}
