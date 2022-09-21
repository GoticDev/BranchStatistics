//
//  StaticsViewController.swift
//  BranchStatistics
//
//  Created by Victor De la Torre on 20/09/22.
//

import UIKit
import Combine
import Charts

class StatisticsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var statisticsViewModel = StatisticsViewModel(statisticsService: StatisticsServices.shared)
    var cancellables: Set<AnyCancellable> = []
    
    var dataList: [DataStatiscResponse] = [DataStatiscResponse]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundStatistics
        statisticsViewModel.getStatistics()
        registerTableView()
        bindingList()
    }
    
    private func bindingList() {
        statisticsViewModel.statisticsList
            .sink { subs in
                switch subs {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { (response) in
                guard response.isEmpty == true else {
                    let alert = UIAlertController(title: "Lo sentimos!", message: "Vuelve a intentarlo mas tarde.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                self.dataList = response
                self.tableView.reloadData()
            }.store(in: &cancellables)

    }

    private func registerTableView() {
        let nib2 = UINib(nibName: "Statistics2TableViewCell", bundle: nil)
        let nib6 = UINib(nibName: "Statistics6TableViewCell", bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier: "Statistics2TableViewCell")
        tableView.register(nib6, forCellReuseIdentifier: "Statistics6TableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

extension StatisticsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if dataList[indexPath.row].values.count == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Statistics2TableViewCell", for: indexPath) as? Statistics2TableViewCell else { return UITableViewCell() }
            cell.contentData(data: dataList[indexPath.row])
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Statistics6TableViewCell", for: indexPath) as? Statistics6TableViewCell else { return UITableViewCell() }
            cell.contentData(data: dataList[indexPath.row])
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
}
