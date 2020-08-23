//
//  IconAlerController.swift
//  CovidStatsITA
//
//  Created by Matteo Visotto on 23/08/2020.
//  Copyright © 2020 Matteo Visotto. All rights reserved.
//

import UIKit

enum IconAlertControllerType {
    case success
    case warning
    case danger
}

class IconAlertController: UIViewController {

    open var alertType: IconAlertControllerType! = .success {
        didSet{
            switch alertType {
            case .danger:
                typeColor = UIColor.danger
                typeIcon = UIImage(named: "danger")!
            case .warning:
                typeColor = UIColor.warning
                typeIcon = UIImage(named: "warning")!
            default:
                typeColor = UIColor.success
                typeIcon = UIImage(named: "success")!
            }
        }
    }
    
    private var typeColor: UIColor = UIColor.success {
        didSet{
            badgeImage.tintColor = typeColor
            imageContainer.layer.borderColor = typeColor.cgColor
            containerView.layer.borderColor = typeColor.cgColor
            dismissButton.setTitleColor(typeColor, for: .normal)
        }
    }
    private var typeIcon: UIImage = UIImage(named: "success")! {
        didSet{
            badgeImage.image = typeIcon
        }
    }
    
    private var containerView = UIView()
    private var contentLabel = UILabel()
    private var badgeImage = UIImageView()
    private var imageContainer = UIView()
    private var dismissButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        setupUI()
    }
    
    private func setupUI() {
       
        self.view.addSubview(containerView)
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
       
        self.view.addSubview(imageContainer)
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        imageContainer.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imageContainer.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageContainer.topAnchor.constraint(equalTo: containerView.topAnchor, constant: -30).isActive = true
        imageContainer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        imageContainer.layer.cornerRadius = 30
        imageContainer.layer.borderWidth = 3
        if #available(iOS 13.0, *) {
            imageContainer.backgroundColor = .systemBackground
        } else {
            imageContainer.backgroundColor = .white
        }
        
        imageContainer.addSubview(badgeImage)
        badgeImage.translatesAutoresizingMaskIntoConstraints = false
        badgeImage.topAnchor.constraint(equalTo: imageContainer.topAnchor, constant: 10).isActive = true
        badgeImage.leftAnchor.constraint(equalTo: imageContainer.leftAnchor, constant: 10).isActive = true
        badgeImage.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: -10).isActive = true
        badgeImage.rightAnchor.constraint(equalTo: imageContainer.rightAnchor, constant: -10).isActive = true
        badgeImage.contentMode = .scaleAspectFit
        
        self.containerView.addSubview(contentLabel)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.topAnchor.constraint(equalTo: badgeImage.bottomAnchor, constant: 15).isActive = true
        contentLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15).isActive = true
        contentLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15).isActive = true
        contentLabel.numberOfLines = 0
        contentLabel.textAlignment = .justified
        
        containerView.addSubview(dismissButton)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 10).isActive = true
        dismissButton.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        dismissButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        dismissButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        dismissButton.setTitle("OK", for: .normal)
        dismissButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        dismissButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
    }
    
    func setContent(content: String) {
        contentLabel.text = content
    }
    
    @objc private func dismissAlert() {
        self.dismiss(animated: true, completion: nil)
    }
}

