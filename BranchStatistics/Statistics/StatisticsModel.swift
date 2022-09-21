//
//  StatisticsModel.swift
//  BranchStatistics
//
//  Created by Victor De la Torre on 20/09/22.
//

import Foundation

struct StatisticsResponse: Codable {
    let data: [DataStatiscResponse]
}
            
struct DataStatiscResponse: Codable {
    let pregunta: String
    let values: [ValuesResponse]
}

struct ValuesResponse: Codable {
    let label: String
    let value: Int
}
