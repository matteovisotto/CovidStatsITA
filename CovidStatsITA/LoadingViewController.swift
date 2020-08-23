//
//  LoadingViewController.swift
//  CovidStatsITA
//
//  Created by Matteo Visotto on 23/08/2020.
//  Copyright © 2020 Matteo Visotto. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    private var appLogo = UIImageView()
    private var statusLabel = UILabel()
    private var dataDownloader: DataDownloader!
    private var downloadCounter = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
        loadData()
    }
    
    private func setupUI() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(appLogo)
        stackView.addArrangedSubview(statusLabel)
        self.view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        appLogo.translatesAutoresizingMaskIntoConstraints = false
        appLogo.widthAnchor.constraint(equalToConstant: 150).isActive = true
        appLogo.heightAnchor.constraint(equalToConstant: 150).isActive = true
        statusLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        statusLabel.textAlignment = .center
        appLogo.backgroundColor = .clear
        appLogo.image = UIImage(named: "covid")
        statusLabel.text = "Caricamento dati in corso"
        
    }
    
    private func changeViewController() {
        if #available(iOS 13.0, *){
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate
            else {
              return
            }
            let rootViewController = MainViewController()
            sceneDelegate.window?.rootViewController = rootViewController
            rootViewController.view.backgroundColor = .systemBackground
        } else {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let rootViewController = MainViewController()
            appDelegate.window!.rootViewController = rootViewController
            appDelegate.window!.makeKeyAndVisible()
            rootViewController.view.backgroundColor = .white
        }
       
    }
    
    private func loadData() {
        dataDownloader = DataDownloader(downloadType: .italia)
        dataDownloader.delegate = self
        dataDownloader.start()
    }
}

extension LoadingViewController: DataDownloaderDelegate {
    func didDownload(result: Bool, data: [Dictionary<String, Any>], forDownloadCase downloadCase: APIUrlsType) {
        DispatchQueue.main.async {
            if(result){
                self.downloadCounter = self.downloadCounter + 1
                switch downloadCase {
                case .italia:
                    Model.shared.setItaData(from: data)
                    self.dataDownloader = DataDownloader(downloadType: .regioni)
                    self.dataDownloader.delegate = self
                    self.dataDownloader.start()
                    break
                case .regioni:
                    Model.shared.setRegioniData(from: data)
                    self.dataDownloader = DataDownloader(downloadType: .province)
                    self.dataDownloader.delegate = self
                    self.dataDownloader.start()
                    break
                case .province:
                    Model.shared.setProvinceData(from: data)
                    self.dataDownloader = DataDownloader(downloadType: .note)
                    self.dataDownloader.delegate = self
                    self.dataDownloader.start()
                    break
                case .note:
                    Model.shared.addNoteToItaData(from: data)
                    break
                default:
                    break
                }
                
                if(self.downloadCounter == 4){
                    self.changeViewController()
                }
            } else {
                print("Errore nel download")
            }
        }
        
    }
    
    
}
