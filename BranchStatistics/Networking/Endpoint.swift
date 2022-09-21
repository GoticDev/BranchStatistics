//
//  Endpoint.swift
//  BranchStatistics
//
//  Created by Victor De la Torre on 20/09/22.
//

import Foundation

public protocol EndpointProtocol {
    
    var path: String { get }
    
}

public extension EndpointProtocol {
    
    func url(withBaseURL baseURL: String, queryItems: [URLQueryItem] = []) -> URL? {
        guard var components = URLComponents(string: baseURL+path) else { return nil }
        components.queryItems = queryItems
        return components.url
    }
    
}

public struct Endpoint: EndpointProtocol {
    
    public var path: String
    
    public init(path: String) {
        self.path = path
    }

}


extension Endpoint {
    
    static public var statistics: Endpoint {
        Endpoint(path: "/dev.reports.files/test.json")
    }

}
