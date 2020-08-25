//
//  ProvinciaCollectionViewCell.swift
//  CovidStatsITA
//
//  Created by Matteo Visotto on 25/08/2020.
//  Copyright © 2020 Matteo Visotto. All rights reserved.
//

import UIKit

class ProvinciaCollectionViewCell: UICollectionViewCell {
 static let cellIdentifier = "provinciaCollectionViewCell"
    
    private let nomeProvincia = UILabel()
    private let nuoviPositivi = UILabel()
    private let nuoviMorti = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.layer.cornerRadius = 10
        if #available(iOS 13.0, *) {
            self.backgroundColor = .systemBackground
        } else {
            self.backgroundColor = .white
        }
        self.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.5
        
        self.addSubview(nomeProvincia)
        self.addSubview(nuoviPositivi)
        self.addSubview(nuoviMorti)
        
        nomeProvincia.translatesAutoresizingMaskIntoConstraints = false
        nuoviPositivi.translatesAutoresizingMaskIntoConstraints = false
        nuoviMorti.translatesAutoresizingMaskIntoConstraints = false
        
        nomeProvincia.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        nuoviPositivi.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        nuoviMorti.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        
        nomeProvincia.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        nuoviPositivi.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        nuoviMorti.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        
        nomeProvincia.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        nuoviPositivi.topAnchor.constraint(equalTo: nomeProvincia.bottomAnchor, constant: 10).isActive = true
        nuoviMorti.topAnchor.constraint(equalTo: nuoviPositivi.bottomAnchor, constant: 10).isActive = true
        nuoviMorti.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        nuoviPositivi.textAlignment = .right
        nuoviMorti.textAlignment = .right
        
        nomeProvincia.font = .boldSystemFont(ofSize: 20)
        nuoviPositivi.font = .boldSystemFont(ofSize: 18)
        nuoviMorti.font = .boldSystemFont(ofSize: 18)
    }
    
    func setProvincia(provincia: Provincia, forDate: Date) {
        self.nomeProvincia.text = provincia.nome
        self.nuoviPositivi.text = "Positivi totali: \((provincia.getCovidData(forDate: forDate) ?? CovidProvinciaData.zero).totalePositivi)"
        self.nuoviMorti.text = "Nuovi positivi: +\((provincia.getCovidData(forDate: forDate) ?? CovidProvinciaData.zero).nuoviPositivi)"
    }
    
}
