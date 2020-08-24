//
//  SwitchTableViewCell.swift
//  CovidStatsITA
//
//  Created by Matteo Visotto on 24/08/2020.
//  Copyright © 2020 Matteo Visotto. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "switchTableViewCell"
    
    let switchControl = UISwitch()
    let label = UILabel()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupUI()
    }
    
    private func setupUI(){
        self.selectionStyle = .none
        self.addSubview(label)
        self.addSubview(switchControl)
        label.translatesAutoresizingMaskIntoConstraints = false
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        label.rightAnchor.constraint(equalTo: switchControl.leftAnchor, constant: -5).isActive = true
        switchControl.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        switchControl.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        switchControl.onTintColor = .success
        
    }
    
    func setCell(cellDescription: String, target: Any, selector: Selector, forEvent: UIControl.Event, withDefaultState defaultState: Bool) {
        self.label.text = cellDescription
        self.switchControl.addTarget(target, action: selector, for: forEvent)
        self.switchControl.isOn = defaultState
    }
    
}
