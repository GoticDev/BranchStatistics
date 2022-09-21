//
//  Statistics6TableViewCell.swift
//  BranchStatistics
//
//  Created by Victor De la Torre on 20/09/22.
//

import UIKit
import Charts

class Statistics6TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var item1Label: UILabel!
    @IBOutlet weak var item2Label: UILabel!
    @IBOutlet weak var item3Label: UILabel!
    @IBOutlet weak var item4Label: UILabel!
    @IBOutlet weak var item5Label: UILabel!
    @IBOutlet weak var item6Label: UILabel!
    
    @IBOutlet weak var item1View: UIView!
    @IBOutlet weak var item2View: UIView!
    @IBOutlet weak var item3View: UIView!
    @IBOutlet weak var item4View: UIView!
    @IBOutlet weak var item5View: UIView!
    @IBOutlet weak var item6View: UIView!
    
    @IBOutlet weak var graphView: BaseGraph!
    @IBOutlet weak var graphWidth: NSLayoutConstraint!
    @IBOutlet weak var graphHeight: NSLayoutConstraint!
    
    var entries: [ChartDataEntry] = [ChartDataEntry]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        graphView.delegate = self
        graphView.setup()
        graphWidth.constant = graphView.frame.width
        graphHeight.constant = graphView.frame.width
        item1View.backgroundColor = .red
        item2View.backgroundColor = .blue
        item3View.backgroundColor = .yellow
        item4View.backgroundColor = .black
        item5View.backgroundColor = .systemPink
        item6View.backgroundColor = .gray
        
        item1View.layer.cornerRadius = item1View.frame.height / 2
        item2View.layer.cornerRadius = item1View.frame.height / 2
        item3View.layer.cornerRadius = item1View.frame.height / 2
        item4View.layer.cornerRadius = item1View.frame.height / 2
        item5View.layer.cornerRadius = item1View.frame.height / 2
        item6View.layer.cornerRadius = item1View.frame.height / 2
    }

    
    func contentData(data: DataStatiscResponse) {
        titleLabel.text = data.pregunta
        item1Label.text = "\(data.values[0].label) \(data.values[0].value)%"
        item2Label.text = "\(data.values[1].label) \(data.values[1].value)%"
        item3Label.text = "\(data.values[2].label) \(data.values[2].value)%"
        item4Label.text = "\(data.values[3].label) \(data.values[3].value)%"
        item5Label.text = "\(data.values[4].label) \(data.values[4].value)%"
        item6Label.text = "\(data.values[5].label) \(data.values[5].value)%"
        
        for i in 0...data.values.count-1 {
            entries.append(ChartDataEntry(x: Double(data.values[i].value), y: Double(data.values[i].value)))
        }
    }
}

extension Statistics6TableViewCell: BaseGraphDelegate {
    func setValues(completion: @escaping ([ChartDataEntry]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            completion(self.entries)
        }
    }
}
