//
//  ScoreViewInitilizer.swift
//  CreditScoreDemoApp
//
//  Created by Vishwas Mukund on 17/11/22.
//

import UIKit

open class ScoreViewInitilizer {
    private static let viewModel = InitlizerViewModel()
    
    public static func initiateAppFlow(with controller: UIViewController, jsonData: Data) {
        guard let scoreData = viewModel.parseData(with: jsonData) else { return }
        let scoreViewModel = ScoreViewModel(with: scoreData)
        let scoreOverviewController = ScoreOverviewController(scoreViewModel: scoreViewModel)
        
        let navigationController = UINavigationController(rootViewController: scoreOverviewController)
        controller.presentViewController(navigationController)
    }
    
    public static func openJsonFile(fileName: String) -> Data {
        var data: Data?
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                data = try Data(NSData(contentsOfFile: path))
            } catch {
                print(error)
            }
        }
        
        return data ?? Data()
    }
}
