//
//  PulsanteCollectionViewCell.swift
//  CovidStatsITA
//
//  Created by Matteo Visotto on 23/08/2020.
//  Copyright © 2020 Matteo Visotto. All rights reserved.
//

import UIKit

class PulsanteCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "pulsanteCollectionViewCell"
    
    private let label = UILabel()
    private let imageView = UIImageView()
    
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
            imageView.tintColor = .label
        } else {
            self.backgroundColor = .white
            imageView.tintColor = .black
        }
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = false
        self.addSubview(label)
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.image = UIImage(named: "rightArrow")!
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        label.rightAnchor.constraint(equalTo: imageView.leftAnchor, constant: -10).isActive = true
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = .zero
        
        self.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.5
    }
    
    public func setButton(text: String){
        label.text = text
    }
}
