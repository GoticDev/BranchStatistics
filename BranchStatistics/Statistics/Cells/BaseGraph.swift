//
//  BaseGraph.swift
//  BranchStatistics
//
//  Created by Victor De la Torre on 20/09/22.
//

import Foundation
import Charts
import ProgressHUD

protocol BaseGraphDelegate: AnyObject {
    func setValues(completion: @escaping ([ChartDataEntry]) -> Void)
}

@IBDesignable
public class BaseGraph: UIView, ChartViewDelegate {
    
    public var pieChart = PieChartView()
    weak var delegate: BaseGraphDelegate?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    
    func setup() {
        pieChart.delegate = self
        
        pieChart.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.addSubview(pieChart)
        
        var entries: [ChartDataEntry] = [ChartDataEntry]()
        ProgressHUD.show()
        delegate?.setValues(completion: { response in
            ProgressHUD.dismiss()
            entries = response
            let set = PieChartDataSet(entries: entries)
            set.colors = ChartColorTemplates.pastel()
            let data = PieChartData(dataSet: set)
            self.pieChart.data = data
        })
        
    }
}


