//
//  ScoreViewModel.swift
//  CreditScoreDemoApp
//
//  Created by Vishwas Mukund on 17/11/22.
//

import Foundation

final class InitlizerViewModel {
    func parseData(with data: Data) -> ScoreData? {
        do {
            let jsonDecoder = JSONDecoder()
            let scoreData = try jsonDecoder.decode(ScoreData.self, from: data)
            return scoreData
        } catch {
            print(error)
        }
        
        return nil
    }
}
