//
//  Services.swift
//  BranchStatistics
//
//  Created by Victor De la Torre on 20/09/22.
//

import Foundation
import Combine

protocol StatisticsServiceProtocol {
    var networkManager: NetworkManagerProtocol { get }
    func getstatistics() -> AnyPublisher<StatisticsResponse, Error>
//    func getPublications(userId: String) -> AnyPublisher<[PublicationsResponse], Error>
}


struct StatisticsServices: StatisticsServiceProtocol {
    
    static let shared: StatisticsServices = {
        guard let manager = AppDelegate.sharedNetworkManager else {
            preconditionFailure("Missing Network Manager")
        }
        return StatisticsServices(networkManager: manager)
    }()
    
    var networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func getstatistics() -> AnyPublisher<StatisticsResponse, Error> {
        let request = HTTPRequest<EmptyData, StatisticsResponse>(endpoint: Endpoint.statistics)
        return self.networkManager.request(request)
    }
    
//    func getPublications(userId: String) -> AnyPublisher<[PublicationsResponse], Error> {
//        var request = HTTPRequest<EmptyData, [PublicationsResponse]>(endpoint: Endpoint.publications)
//        request.queryItems = [URLQueryItem(name: "userId", value: "\(userId)")]
//        return self.networkManager.request(request)
//    }
}
