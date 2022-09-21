//
//  RequestMethod.swift
//  BranchStatistics
//
//  Created by Victor De la Torre on 20/09/22.
//

import Foundation

public protocol RequestMethod {
    var rawValue: String { get }
}

public enum HTTPMethod: String, RequestMethod {
    case get = "GET"
}
