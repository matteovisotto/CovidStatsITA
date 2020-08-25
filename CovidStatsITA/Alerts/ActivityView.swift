//
//  ActivityView.swift
//  CovidStatsITA
//
//  Created by Matteo Visotto on 25/08/2020.
//  Copyright © 2020 Matteo Visotto. All rights reserved.
//

import Foundation
import UIKit

class ActivityView: UIView {
    private var containerView = UIView()
    private var contentLabel = UILabel()
    private var activityIndicator = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(containerView)
        
        containerView.layer.borderColor = UIColor.gray.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.widthAnchor.constraint(equalToConstant: self.frame.width-35).isActive = true
        containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 30).isActive = true
        containerView.layer.cornerRadius = 10
        containerView.layer.borderWidth = 2
        
        if #available(iOS 13.0, *) {
            containerView.backgroundColor = .systemBackground
        } else {
            containerView.backgroundColor = .white
        }
        
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.widthAnchor.constraint(equalToConstant: 30).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 30).isActive = true
        activityIndicator.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        activityIndicator.startAnimating()
        
        containerView.addSubview(contentLabel)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15).isActive = true
        contentLabel.leftAnchor.constraint(equalTo: activityIndicator.rightAnchor, constant: 5).isActive = true
        contentLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15).isActive = true
        contentLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15).isActive = true
        contentLabel.numberOfLines = 0
    }
    
    func setContent(content: String) {
        contentLabel.text = content
    }
}
