//
//  PositiviCollectionViewCell.swift
//  CovidStatsITA
//
//  Created by Matteo Visotto on 23/08/2020.
//  Copyright © 2020 Matteo Visotto. All rights reserved.
//

import UIKit

class PositiviCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "positiviCollectionViewCell"
    
    private let dataTitle = UILabel()
    private let dataValue = UILabel()
    
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
        addSubview(dataTitle)
        addSubview(dataValue)
        
        
        dataTitle.translatesAutoresizingMaskIntoConstraints = false
        dataValue.translatesAutoresizingMaskIntoConstraints = false
       
        
        dataTitle.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        dataTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        dataTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        
        dataValue.topAnchor.constraint(equalTo: dataTitle.bottomAnchor, constant: 5).isActive = true
        dataValue.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        dataValue.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        dataValue.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        dataTitle.font = .boldSystemFont(ofSize: 18)
        dataValue.font = .boldSystemFont(ofSize: 20)
        
        
        dataValue.textAlignment = .center
        
        
        self.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.5
    }
    
    public func setData(nuoviPositivi: Int) {
        dataTitle.text = "Nuovi positivi"
        if(nuoviPositivi == 0){
            dataValue.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        } else {
            dataValue.textColor = .red
        }
        dataValue.text = "+\(nuoviPositivi)"
    }
    
}
