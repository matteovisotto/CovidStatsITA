//
//  StoricoProvinceViewController.swift
//  CovidStatsITA
//
//  Created by Matteo Visotto on 25/08/2020.
//  Copyright © 2020 Matteo Visotto. All rights reserved.
//

import UIKit

class StoricoProvinceViewController: UIViewController {
    
    open var regione: Regione!
    
    private var collectionView: UICollectionView!
    private var currentDate: Date!
    private var availableDates: [Date]!
    private var province: [Provincia] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Province"
        setupUI()
        loadData()
        self.availableDates = Model.shared.getDateArray()
        self.currentDate = self.availableDates.last!
        registerComponents()
        collectionView.dataSource = self
        collectionView.delegate = self
            
    }
    
    private func setupUI(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.frame = self.view.frame
        collectionView.backgroundColor = .clear
    }
    
    private func registerComponents() {
     collectionView.register(PulsanteCollectionViewCell.self, forCellWithReuseIdentifier: PulsanteCollectionViewCell.cellIdentifier)
        collectionView.register(ProvinciaCollectionViewCell.self, forCellWithReuseIdentifier: ProvinciaCollectionViewCell.cellIdentifier)
    }
    
    private func loadData() {
        if(!UserDefaults.standard.bool(forKey: "loadProvince") && !Model.shared.isProvinceDownloaded()) {
            //Call data tast
            let downloadTask = DataDownloader(downloadType: .province)
            downloadTask.delegate = self
            downloadTask.start()
        } else {
            self.province = self.regione.getProvinceArray()
        }
    }
    
}

extension StoricoProvinceViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0){
            return 1
        }
        
        return self.province.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.section == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PulsanteCollectionViewCell.cellIdentifier, for: indexPath) as! PulsanteCollectionViewCell
            cell.setButton(text: "\(Date.getDateForCurrentLocale(date: self.currentDate, withDataFormat: "dd/MM/yyyy"))")
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProvinciaCollectionViewCell.cellIdentifier, for: indexPath) as! ProvinciaCollectionViewCell
        cell.setProvincia(provincia: self.province[indexPath.item], forDate: currentDate)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: self.collectionView.frame.width-20, height: 100)
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.section == 0) {
            let dateSelector = DateSelectorController()
            dateSelector.dataSource = self
            dateSelector.delegate = self
            dateSelector.providesPresentationContextTransitionStyle = true
            dateSelector.definesPresentationContext = true
            dateSelector.modalPresentationStyle = .overFullScreen
            dateSelector.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(dateSelector, animated: true, completion: nil)
        }
    }
}

extension StoricoProvinceViewController: DataDownloaderDelegate {
    func didDownload(result: Bool, data: [Dictionary<String, Any>], forDownloadCase downloadCase: APIUrlsType) {
        DispatchQueue.main.async {
            Model.shared.setProvinceData(from: data)
            self.province = self.regione.getProvinceArray()
            self.collectionView.reloadData()
        }
        
    }
    
    
}

extension StoricoProvinceViewController: DateSelectorDelegate, DateSelectorDataSource {
    func dateSelectorPreselectedDate() -> Date {
        return self.currentDate
    }
    
    func dateSelector(didSelectDate date: Date) {
        self.currentDate = date
        self.collectionView.reloadData()
    }
    
    func dateSelectorAvailableDates(presentDataIn: DateSelectorController) -> [Date] {
        return self.availableDates
    }
}
