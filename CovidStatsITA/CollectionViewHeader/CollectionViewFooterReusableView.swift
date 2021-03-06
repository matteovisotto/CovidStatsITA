//
//  CollectionViewFooterReusableView.swift
//  CovidStatsITA
//
//  Created by Matteo Visotto on 23/08/2020.
//  Copyright © 2020 Matteo Visotto. All rights reserved.
//

import UIKit

class CollectionViewFooterReusableView: UICollectionReusableView {
    static let viewIdentifier = "labelFooterCollectionReusableView"
    
    private let titleLabel: UILabel = UILabel()
    
    private func setupUI() {
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        titleLabel.font = .systemFont(ofSize: 15)
        titleLabel.textAlignment = .center
    }
    
    public func setView(withTextConter title: String){
        setupUI()
        titleLabel.text = title
    }
}
