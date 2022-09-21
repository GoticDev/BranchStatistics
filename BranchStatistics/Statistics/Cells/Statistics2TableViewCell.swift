//
//  Statistics2TableViewCell.swift
//  BranchStatistics
//
//  Created by Victor De la Torre on 20/09/22.
//

import UIKit
import Charts
import Combine

class Statistics2TableViewCell: UITableViewCell {
    

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yesLabel: UILabel!
    @IBOutlet weak var noLabel: UILabel!
    @IBOutlet weak var yesView: UIView!
    @IBOutlet weak var noView: UIView!
    @IBOutlet weak var graphView: BaseGraph!
    @IBOutlet weak var graphWidth: NSLayoutConstraint!
    @IBOutlet weak var graphHeight: NSLayoutConstraint!
    
    var entries: [ChartDataEntry] = [ChartDataEntry]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        graphView.delegate = self
        graphView.setup()
        
        yesView.backgroundColor = .red
        noView.backgroundColor = .blue
        yesView.layer.cornerRadius = yesView.frame.height / 2
        noView.layer.cornerRadius = noView.frame.height / 2
        graphWidth.constant = graphView.frame.width
        graphHeight.constant = graphView.frame.width
        
        
    }
    
    func contentData(data: DataStatiscResponse) {
        titleLabel.text = data.pregunta
        yesLabel.text = "\(data.values[0].label) \(data.values[0].value)%"
        noLabel.text = "\(data.values[1].label) \(data.values[1].value)%"
        
        for i in 0...data.values.count-1 {
            entries.append(ChartDataEntry(x: Double(data.values[i].value), y: Double(data.values[i].value)))
        }
        
    }
    
}

extension Statistics2TableViewCell: BaseGraphDelegate {
    func setValues(completion: @escaping ([ChartDataEntry]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            completion(self.entries)
        }
    }
}
