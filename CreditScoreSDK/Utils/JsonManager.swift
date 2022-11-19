//
//  File.swift
//  CreditScoreDemoApp
//
//  Created by Vishwas Mukund on 17/11/22.
//

import Foundation

open class JsonManager {
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
