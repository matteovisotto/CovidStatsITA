//
//  LabelTableViewCell.swift
//  CovidStatsITA
//
//  Created by Matteo Visotto on 24/08/2020.
//  Copyright © 2020 Matteo Visotto. All rights reserved.
//

import UIKit

class LabelTableViewCell: UITableViewCell {

   static let cellIdentifier = "labelTableViewCell"
    
    let label = UILabel()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupUI()
    }
    
    private func setupUI(){
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
    }
    
    func setCell(cellDescription: String, accessoryType: UITableViewCell.AccessoryType) {
        self.label.text = cellDescription
        self.accessoryType = accessoryType
    }

}
