//
//  StoricoItaliaViewController.swift
//  CovidStatsITA
//
//  Created by Matteo Visotto on 24/08/2020.
//  Copyright © 2020 Matteo Visotto. All rights reserved.
//

import UIKit

class StoricoItaliaViewController: UIViewController {
    
    private var displayDate: Date!
    private var collectionView: UICollectionView!
    
    private var currentDate: Date!
    private var availableDates: [Date]!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Storico"
        setupUI()
        self.availableDates = Model.shared.getDateArray()
        self.currentDate = self.availableDates[self.availableDates.count-2]
        registerComponents()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.frame = self.view.frame
        collectionView.backgroundColor = .clear
    }
    
    private func registerComponents() {
        collectionView.register(DataCollectionViewCell.self, forCellWithReuseIdentifier: DataCollectionViewCell.cellIdentifier)
        collectionView.register(PositiviCollectionViewCell.self, forCellWithReuseIdentifier: PositiviCollectionViewCell.cellIdentifier)
        collectionView.register(NoteCollectionViewCell.self, forCellWithReuseIdentifier: NoteCollectionViewCell.cellIdentifier)
        collectionView.register(PulsanteCollectionViewCell.self, forCellWithReuseIdentifier: PulsanteCollectionViewCell.cellIdentifier)
        collectionView.register(PercentCollectionViewCell.self, forCellWithReuseIdentifier: PercentCollectionViewCell.cellIdentifier)
    }
    
}

extension StoricoItaliaViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0){
            return 1
        } else if(section == 1){
            if(Model.shared.getItaData().count>0){
                return 8
            }
            return 0
        } else {
            if(Model.shared.getItaData(forDate: self.currentDate)?.note.isEmpty ?? true) {
                return 0
            }
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.section == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PulsanteCollectionViewCell.cellIdentifier, for: indexPath) as! PulsanteCollectionViewCell
            cell.setButton(text: "\(Date.getDateForCurrentLocale(date: self.currentDate, withDataFormat: "dd/MM/yyyy"))")
            return cell
        } else if(indexPath.section == 1){
            //Bollettino
            if(indexPath.item == 0){
                //Nuovi positivi
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PositiviCollectionViewCell.cellIdentifier, for: indexPath) as! PositiviCollectionViewCell
                cell.setData(nuoviPositivi: Model.shared.getItaData(forDate: self.currentDate)?.nuoviPositivi ?? CovidData.zero.nuoviPositivi)
                return cell
            } else if (indexPath.item == 1){
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PercentCollectionViewCell.cellIdentifier, for: indexPath) as! PercentCollectionViewCell
                cell.setData(covidData: Model.shared.getItaData(forDate: self.currentDate) ?? CovidData.zero)
                return cell
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DataCollectionViewCell.cellIdentifier, for: indexPath) as! DataCollectionViewCell
            switch indexPath.item {
            case 2:
                cell.setData(itaData: Model.shared.getItaData(forDate: self.currentDate) ?? CovidData.zero, cellType: .positivi)
                break
            case 3:
                cell.setData(itaData: Model.shared.getItaData(forDate: self.currentDate) ?? CovidData.zero, cellType: .morti)
                break
            case 4:
                cell.setData(itaData: Model.shared.getItaData(forDate: self.currentDate) ?? CovidData.zero, cellType: .terapieIntensive)
                break
            case 5:
                cell.setData(itaData: Model.shared.getItaData(forDate: self.currentDate) ?? CovidData.zero, cellType: .tamponi)
                break
            case 6:
                cell.setData(itaData: Model.shared.getItaData(forDate: self.currentDate) ?? CovidData.zero, cellType: .dimessi)
                break
            case 7:
                cell.setData(itaData: Model.shared.getItaData(forDate: self.currentDate) ?? CovidData.zero, cellType: .ricoveri)
                break
            case 8:
                cell.setData(itaData: Model.shared.getItaData(forDate: self.currentDate) ?? CovidData.zero, cellType: .diagnostico)
                break
            case 9:
                cell.setData(itaData: Model.shared.getItaData(forDate: self.currentDate) ?? CovidData.zero, cellType: .screening)
                break
            default:
                cell.setData(itaData: Model.shared.getItaData(forDate: self.currentDate) ?? CovidData.zero, cellType: .positivi)
            }
            return cell
        } else {
            //Note
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoteCollectionViewCell.cellIdentifier, for: indexPath) as! NoteCollectionViewCell
            cell.setNote(text: Model.shared.getItaData(forDate: self.currentDate)?.note ?? "")
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.section == 0){
            return CGSize(width: collectionView.frame.width-20, height: collectionView.frame.width/4-20)
        }
        if(indexPath.section == 1){
            if(indexPath.item == 0 || indexPath.item == 1){
                return CGSize(width: collectionView.frame.width-20, height: collectionView.frame.width/4)
            } else {
                return CGSize(width: collectionView.frame.width/2-20, height: 150)
            }
        } else {
            return CGSize(width: collectionView.frame.width-20, height: collectionView.frame.width/3-20)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         if(indexPath.section==2){
            let customAlert = IconAlertController()
            customAlert.providesPresentationContextTransitionStyle = true
            customAlert.definesPresentationContext = true
            customAlert.modalPresentationStyle = .overFullScreen
            customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            customAlert.alertType = .warning
            customAlert.setContent(content: Model.shared.getItaData(forDate: self.currentDate)?.note ?? "")
            self.present(customAlert, animated: true, completion: nil)
        } else if(indexPath.section == 0){
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

extension StoricoItaliaViewController: DateSelectorDelegate, DateSelectorDataSource {
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
