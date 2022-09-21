//
//  HomeViewModel.swift
//  BranchStatistics
//
//  Created by Victor De la Torre on 20/09/22.
//

import Foundation

class HomeViewModel {
    
//    private var statisticsSubscription: AnyCancellable?
//    private var statisticsService: StatisticsServiceProtocol
//    
//    var statisticsData: [DataStatiscResponse]?
//    
//    init(statisticsService: StatisticsServiceProtocol) {
//        self.statisticsService = statisticsService
//    }
//    
//    deinit {
//        self.cancel()
//    }
//    
//    func getStatistics() {
//        if let currentSuscription = statisticsSubscription {
//            currentSuscription.cancel()
//        }
//        self.statisticsSubscription = statisticsService.getstatistics()
//            .sink(receiveCompletion: { (receiveCompletion) in
//                switch receiveCompletion {
//                case .finished:
//                    print("finished")
//                case .failure(let error):
//                    print("error:", error)
//                }
//            }, receiveValue: { (response) in
//                debugPrint(response.data)
//                self.statisticsData = response.data
//            })
//    }
//    
//    func cancel() {
//        statisticsSubscription?.cancel()
//    }
}
