//
//  Request.swift
//  BranchStatistics
//
//  Created by Victor De la Torre on 20/09/22.
//

import Foundation

public struct EmptyData: Codable {}

public protocol RequestProtocol {
    
    associatedtype Request: Codable
    associatedtype Response: Codable
    
    var endpoint: EndpointProtocol { get }
    var method: RequestMethod? { get }
    var queryItems: [URLQueryItem] { get }
    
}

public struct HTTPRequest<Request: Codable, Response: Codable>: RequestProtocol {
    
    public var endpoint: EndpointProtocol
    public var method: RequestMethod?
    public var queryItems: [URLQueryItem]
    
    public init(endpoint: EndpointProtocol, method: HTTPMethod = .get, queryItems: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.method = method
        self.queryItems = queryItems
    }
    
}
