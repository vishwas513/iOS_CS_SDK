//
//  ScoreViewModel.swift
//  CreditScoreDemoApp
//
//  Created by Vishwas Mukund on 17/11/22.
//

import Foundation

final class ScoreViewModel {
    var scoreData: ScoreData!
    
    init(with data: ScoreData) {
        scoreData = data
    }
    
    func getPercentage() -> Int {
        let score = Float(scoreData.score.value)
        let rangeEnd = Float(scoreData.scoreOverview.rangeEnd)
        let rangeStart = Float(scoreData.scoreOverview.rangeStart)
        let percentage = ((score - rangeStart) / (rangeEnd - rangeStart)) * 100
        
        return Int(percentage)
    }
    
    func getFormattedDateString() -> String {
        let dateFormatter = DateFormatter()
        let calender = Calendar(identifier: .gregorian)
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        guard let dateObject = dateFormatter.date(from: scoreData.score.lastChecked) else {return ""}
        
        
        
        return "As of \(calender.component(.day, from: dateObject))/\(calender.component(.month, from: dateObject))/\(calender.component(.year, from: dateObject))"
    }
    
    func checkIfScoreInRange(score: Int, range: ScoreRange) -> Bool {
        if score >= range.rangeStart && score <= range.rangeEnd {
            return true
        } else {
            return false
        }
    }
}
