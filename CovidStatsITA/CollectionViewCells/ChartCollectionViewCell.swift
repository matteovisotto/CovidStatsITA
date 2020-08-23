//
//  ChartCollectionViewCell.swift
//  CovidStatsITA
//
//  Created by Matteo Visotto on 23/08/2020.
//  Copyright © 2020 Matteo Visotto. All rights reserved.
//

import UIKit

class ChartCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "chartCollectionViewCell"
    private let chartView = UIView()
    private let lineChart = LineChart()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        if #available(iOS 13.0, *) {
            self.backgroundColor = .systemBackground
        } else {
            self.backgroundColor = .white
        }
        
        self.layer.cornerRadius = 10
        
        self.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.5
        
        self.addSubview(chartView)
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        chartView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        chartView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        chartView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        
        lineChart.area = false
        lineChart.x.grid.visible = false
        lineChart.x.labels.visible = false
        lineChart.y.grid.visible = false
        lineChart.y.labels.visible = false
        lineChart.dots.visible = false
        chartView.addSubview(lineChart)
        lineChart.translatesAutoresizingMaskIntoConstraints = false
        lineChart.topAnchor.constraint(equalTo: chartView.topAnchor).isActive = true
        lineChart.leftAnchor.constraint(equalTo: chartView.leftAnchor).isActive = true
        lineChart.rightAnchor.constraint(equalTo: chartView.rightAnchor).isActive = true
        lineChart.bottomAnchor.constraint(equalTo: chartView.bottomAnchor).isActive = true
    }
    
    public func setData(covidData: [CovidData], target: LineChartDelegate){
        var data: [CGFloat] = []
        var maxValue = 0
        for value in covidData {
            if(value.nuoviPositivi > maxValue){
                maxValue = value.nuoviPositivi
            }
            data.append(CGFloat(value.nuoviPositivi))
        }
        lineChart.delegate = target
        lineChart.y.grid.count = 5
        lineChart.addLine(data)
    }
}
