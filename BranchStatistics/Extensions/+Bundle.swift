//
//  +Bundle.swift
//  BranchStatistics
//
//  Created by Victor De la Torre on 20/09/22.
//

import Foundation

extension Bundle {
    static var baseURL: String? {
        return Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String
    }
    
}
