//
//  ScoreData.swift
//  CreditScoreDemoApp
//
//  Created by Vishwas Mukund on 17/11/22.
//

import Foundation
import UIKit

public struct ScoreData: Decodable {
    public var score: Score
    public var scoreOverview: ScoreOverview
    public var scoreRanges: [ScoreRange]
}

public struct Score: Decodable {
    public var value: Int
    public var lastChecked: String
}

public struct ScoreOverview: Decodable {
    public var rangeStart: Int
    public var rangeEnd: Int
}

public struct ScoreRange: Decodable {
    public var rangeStart: Int
    public var rangeEnd: Int
    public var rangeType: String
    var percentageOfRange: Int
}

public enum RangeType: String {
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
