//
//  ScoreData.swift
//  CreditScoreDemoApp
//
//  Created by Vishwas Mukund on 17/11/22.
//

import Foundation
import UIKit

struct ScoreData: Decodable {
    var score: Score
    var scoreOverview: ScoreOverview
    var scoreRanges: [ScoreRange]
}

struct Score: Decodable {
    var value: Int
    var rangeType: String
    var lastChecked: String
}

struct ScoreOverview: Decodable {
    var rangeStart: Int
    var rangeEnd: Int
}

struct ScoreRange: Decodable {
    var rangeStart: Int
    var rangeEnd: Int
    var rangeType: String
    var percentageOfRange: Int
}

enum RangeType: String {
    case poor, belowAverage, average, good, excellent
    
    func getColor() -> UIColor {
        switch self {
        case .poor:
            return .poor
        case .belowAverage:
            return .belowAverage
        case .average:
            return .medium
        case .good:
            return .good
        case .excellent:
            return .excellent
            
        }
    }
}
