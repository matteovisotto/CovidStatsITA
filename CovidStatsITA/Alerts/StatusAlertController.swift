//
//  File.swift
//  CovidStatsITA
//
//  Created by Matteo Visotto on 24/08/2020.
//  Copyright © 2020 Matteo Visotto. All rights reserved.
//

import Foundation
import UIKit

class StatusAlertController: UIViewController {
    private var containerView = UIView()
    private var contentLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        setupUI()
    }
    
    private func setupUI() {
        self.view.addSubview(containerView)
        self.containerView.layer.borderColor = UIColor.gray.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.widthAnchor.constraint(equalToConstant: self.view.frame.width-35).isActive = true
        containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 30).isActive = true
        containerView.layer.cornerRadius = 10
        containerView.layer.borderWidth = 2
        if #available(iOS 13.0, *) {
            containerView.backgroundColor = .systemBackground
        } else {
            containerView.backgroundColor = .white
        }
        
        self.containerView.addSubview(contentLabel)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15).isActive = true
        contentLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15).isActive = true
        contentLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15).isActive = true
        contentLabel.numberOfLines = 0
    }
    
    func setContent(content: String) {
        contentLabel.text = content
    }
}
