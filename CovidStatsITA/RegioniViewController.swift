//
//  RegioniViewController.swift
//  CovidStatsITA
//
//  Created by Matteo Visotto on 23/08/2020.
//  Copyright © 2020 Matteo Visotto. All rights reserved.
//

import UIKit

class RegioniViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    
    
    private var regioni: [Regione] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Regioni"
        regioni.removeAll()
        regioni = Model.shared.getRegioniArray()
        setupUI()
        collectionView.register(RegioneCollectionViewCell.self, forCellWithReuseIdentifier: RegioneCollectionViewCell.cellIdentifier)
        collectionView.register(CollectionViewInfoReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewInfoReusableView.viewIdentifier)
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
    
}

extension RegioniViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.regioni.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RegioneCollectionViewCell.cellIdentifier, for: indexPath) as! RegioneCollectionViewCell
        cell.setRegione(regione: regioni[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width-20, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let messageView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewInfoReusableView.viewIdentifier, for: indexPath) as! CollectionViewInfoReusableView
        messageView.setView(withTextConter: "Cliccando su una regione è possibile visualizzare i dati completi e gli storici.")
        return messageView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let regione = regioni[indexPath.item]
        let storico = StoricoRegioneViewController()
        storico.regione = regione
        storico.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(storico, animated: false)
    }
}
