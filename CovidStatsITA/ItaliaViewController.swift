//
//  ViewController.swift
//  CovidStatsITA
//
//  Created by Matteo Visotto on 23/08/2020.
//  Copyright © 2020 Matteo Visotto. All rights reserved.
//

import UIKit

class ItaliaViewController: UIViewController {
        
    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Italia"
        setupUI()
        registerCells()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
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
    
    private func registerCells() {
        collectionView.register(CollectionViewReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewReusableView.viewIdentifier)
        collectionView.register(CollectionViewFooterReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CollectionViewFooterReusableView.viewIdentifier)
        collectionView.register(AlertCollectionViewCell.self, forCellWithReuseIdentifier: AlertCollectionViewCell.cellIdentifier)
        collectionView.register(DataCollectionViewCell.self, forCellWithReuseIdentifier: DataCollectionViewCell.cellIdentifier)
        collectionView.register(ChartCollectionViewCell.self, forCellWithReuseIdentifier: ChartCollectionViewCell.cellIdentifier)
        collectionView.register(PulsanteCollectionViewCell.self, forCellWithReuseIdentifier: PulsanteCollectionViewCell.cellIdentifier)
        collectionView.register(PositiviCollectionViewCell.self, forCellWithReuseIdentifier: PositiviCollectionViewCell.cellIdentifier)
        collectionView.register(NoteCollectionViewCell.self, forCellWithReuseIdentifier: NoteCollectionViewCell.cellIdentifier)
        collectionView.register(PercentChartCollectionViewCell.self, forCellWithReuseIdentifier: PercentChartCollectionViewCell.cellIdentifier)
        collectionView.register(PercentCollectionViewCell.self, forCellWithReuseIdentifier: PercentCollectionViewCell.cellIdentifier)
    }
    
}

extension ItaliaViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0){
            if(Model.shared.isUpdated()){
                return 0
            } else {
                return 1
            }
        } else if(section == 1){
            return 1
        } else if(section == 2){
            return 1
        } else if(section == 3){
            if(Model.shared.getItaData().count>0){
                return 8
            }
            return 0
        } else if(section == 4) {
            if(Model.shared.getItaData().last!.note == "") {
                return 0
            }
            
            return 1
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.section == 0){
            //Alert
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlertCollectionViewCell.cellIdentifier, for: indexPath) as! AlertCollectionViewCell
            cell.setError(error: "Gli ultimi dati disponibili si riferiscono a ieri, attendi la pubblicazione del nuovo bollettino per vedere i dati aggiornati")
            return cell
        }else if(indexPath.section == 1) {
            //Chart
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChartCollectionViewCell.cellIdentifier, for: indexPath) as! ChartCollectionViewCell
            cell.setData(covidData: Model.shared.getItaData(), target: self)
            return cell
        } else if(indexPath.section == 2){
            // % positivi-tamponi
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PercentChartCollectionViewCell.cellIdentifier, for: indexPath) as! PercentChartCollectionViewCell
            cell.setData(covidData: Model.shared.getItaData(), target: self)
            return cell
        } else if(indexPath.section == 3){
            //Bollettino
            if(indexPath.item == 0){
                //Nuovi positivi
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PositiviCollectionViewCell.cellIdentifier, for: indexPath) as! PositiviCollectionViewCell
                cell.setData(nuoviPositivi: Model.shared.getItaData().last!.nuoviPositivi)
                return cell
            } else if(indexPath.item == 1){
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PercentCollectionViewCell.cellIdentifier, for: indexPath) as! PercentCollectionViewCell
                cell.setData(covidData: Model.shared.getItaData().last!)
                return cell
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DataCollectionViewCell.cellIdentifier, for: indexPath) as! DataCollectionViewCell
            switch indexPath.item {
            case 2:
                cell.setData(itaData: Model.shared.getItaData().last!, cellType: .positivi)
                break
            case 3:
                cell.setData(itaData: Model.shared.getItaData().last!, cellType: .morti)
                break
            case 4:
                cell.setData(itaData: Model.shared.getItaData().last!, cellType: .terapieIntensive)
                break
            case 5:
                cell.setData(itaData: Model.shared.getItaData().last!, cellType: .tamponi)
                break
            case 6:
                cell.setData(itaData: Model.shared.getItaData().last!, cellType: .dimessi)
                break
            case 7:
                cell.setData(itaData: Model.shared.getItaData().last!, cellType: .ricoveri)
                break
            case 8:
                cell.setData(itaData: Model.shared.getItaData().last!, cellType: .diagnostico)
                break
            case 9:
                cell.setData(itaData: Model.shared.getItaData().last!, cellType: .screening)
                break
            default:
                cell.setData(itaData: Model.shared.getItaData().last!, cellType: .positivi)
            }
            return cell
        } else if(indexPath.section == 4) {
            //Note
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoteCollectionViewCell.cellIdentifier, for: indexPath) as! NoteCollectionViewCell
            cell.setNote(text: Model.shared.getItaData().last!.note)
            return cell
        } else {
            //Storico
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PulsanteCollectionViewCell.cellIdentifier, for: indexPath) as! PulsanteCollectionViewCell
            cell.setButton(text: "Visualizza lo storico")
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.section == 0){
            return CGSize(width: collectionView.frame.width-20, height: 120)
        } else if(indexPath.section == 1 || indexPath.section == 2) {
            return CGSize(width: collectionView.frame.width-20, height: 200)
        } else if(indexPath.section == 3){
            if(indexPath.item == 0 || indexPath.item == 1){
                return CGSize(width: collectionView.frame.width-20, height: collectionView.frame.width/4)
            } else {
                return CGSize(width: collectionView.frame.width/2-20, height: 150)
            }
        } else if(indexPath.section == 4) {
            return CGSize(width: collectionView.frame.width-20, height: collectionView.frame.width/3-20)
        } else {
            return CGSize(width: collectionView.frame.width-20, height: collectionView.frame.width/4-20)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let valoreDiPicco = Model.shared.getItaPicco()
        let mediaNazionale = Model.shared.getMediaNazionaleString(withDecimal: 2)
        if(kind == UICollectionView.elementKindSectionHeader) {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewReusableView.viewIdentifier, for: indexPath) as! CollectionViewReusableView
            if(indexPath.section == 1) {
                headerView.setView(withHeaderTitle: "Andamento totale")
            } else if(indexPath.section == 2) {
                headerView.setView(withHeaderTitle: "% positivi - tamponi")
            } else if(indexPath.section == 3){
                headerView.setView(withHeaderTitle: "L'ultimo bollettino")
            } else {
                headerView.setView(withHeaderTitle: "")
            }

            return headerView
        } else {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewFooterReusableView.viewIdentifier, for: indexPath) as! CollectionViewFooterReusableView
            if(indexPath.section == 1){
                footerView.setView(withTextConter: "Picco: \(valoreDiPicco) casi/24h; Media: \(mediaNazionale)")
            } else {
                footerView.setView(withTextConter: "")
            }
            return footerView
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if(section == 1 || section == 2 || section == 3){
           return CGSize(width: collectionView.frame.width, height: 50)
        }
        return CGSize(width: collectionView.frame.width, height: 0)
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if(section == 1){
            return CGSize(width: collectionView.frame.width, height: 30)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.section==4){
            let customAlert = IconAlertController()
                   customAlert.providesPresentationContextTransitionStyle = true
                   customAlert.definesPresentationContext = true
                   customAlert.modalPresentationStyle = .overFullScreen
                   customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            customAlert.alertType = .warning
            customAlert.setContent(content: Model.shared.getItaData().last!.note)
                   self.present(customAlert, animated: true, completion: nil)
        } else if(indexPath.section == 5){
            let storico = StoricoItaliaViewController()
            storico.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(storico, animated: false)
        }
    }
}

extension ItaliaViewController: LineChartDelegate {
    func didSelectDataPoint(_ x: CGFloat, yValues: [CGFloat]) {
        let footerView = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionFooter, at: IndexPath(item: 0, section: 1)) as! CollectionViewFooterReusableView
        footerView.setView(withTextConter: "\(yValues.first!) casi")
        
        if #available(iOS 10.0, *) {
            _ = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { timer in
                DispatchQueue.main.async {
                    footerView.setView(withTextConter: "Picco: \(Model.shared.getItaPicco()) casi/24h; Media: \(Model.shared.getMediaNazionaleString(withDecimal: 2))")
                }
            }
        }
    }
    
}

