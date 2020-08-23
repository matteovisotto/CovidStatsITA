//
//  NoteCollectionViewCell.swift
//  CovidStatsITA
//
//  Created by Matteo Visotto on 23/08/2020.
//  Copyright © 2020 Matteo Visotto. All rights reserved.
//

import UIKit

class NoteCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "noteCollectionViewCell"
    
    private let label = UILabel()
    private let secondLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setupUI() {
        self.addSubview(label)
        self.addSubview(secondLabel)
        label.translatesAutoresizingMaskIntoConstraints = false
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        secondLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 2).isActive = true
        secondLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        secondLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        secondLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        secondLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        label.numberOfLines = .zero
        
        secondLabel.text = "Clicca per leggere tutto"
        secondLabel.font = .boldSystemFont(ofSize: 15)
        
        self.backgroundColor = .clear
    }
    
    public func setNote(text: String){
        label.text = text
    }
}
