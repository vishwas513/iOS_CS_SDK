//
//  ScoreViewModel.swift
//  CreditScoreDemoApp
//
//  Created by Vishwas Mukund on 17/11/22.
//

import Foundation

open class ScoreViewModel {
    var scoreData: ScoreData!
    
    public init(with data: ScoreData) {
        scoreData = data
    }
    
    open func getPercentage() -> Int {
        let score = Float(scoreData.score.value)
        let rangeEnd = Float(scoreData.scoreOverview.rangeEnd)
        let rangeStart = Float(scoreData.scoreOverview.rangeStart)
        let percentage = ((score - rangeStart) / (rangeEnd - rangeStart)) * 100
        
        return Int(percentage)
    }
    
    open func getFormattedDateString() -> String {
        let dateFormatter = DateFormatter()
        let calender = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = Constants.dateFormat
        
        guard let dateObject = dateFormatter.date(from: scoreData.score.lastChecked) else {return ""}
        
        return "As of \(calender.component(.day, from: dateObject))/\(calender.component(.month, from: dateObject))/\(calender.component(.year, from: dateObject))"
    }
    
    open func checkIfScoreInRange(score: Int, range: ScoreRange) -> Bool {
        if score >= range.rangeStart && score <= range.rangeEnd {
            return true
        } else {
            return false
        }
    }
    
    open func getRangeWith(score: Int) -> RangeType? {
        for rangeType in scoreData.scoreRanges {
            if checkIfScoreInRange(score: score, range: rangeType) {
                return RangeType(rawValue: rangeType.rangeType)
            }
        }
        
        return RangeType.poor
    }
}
