//
//  StatisticsViewModel.swift
//  BranchStatistics
//
//  Created by Victor De la Torre on 20/09/22.
//

import Foundation
import Combine

class StatisticsViewModel {
    var statisticsList = CurrentValueSubject<[DataStatiscResponse], Error>([])
    private var statisticsSubscription: AnyCancellable?
    private var statisticsService: StatisticsServiceProtocol
    
//    var statisticsData: [DataStatiscResponse]?
    
    init(statisticsService: StatisticsServiceProtocol) {
        self.statisticsService = statisticsService
    }
    
    deinit {
        self.cancel()
    }
    
    func getStatistics() {
        if let currentSuscription = statisticsSubscription {
            currentSuscription.cancel()
        }
        self.statisticsSubscription = statisticsService.getstatistics()
            .sink(receiveCompletion: { (receiveCompletion) in
                switch receiveCompletion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print("error:", error)
                }
            }, receiveValue: { (response) in
                debugPrint(response.data)
                self.statisticsList.send(response.data)
            })
    }
    
    func cancel() {
        statisticsSubscription?.cancel()
    }
}


