//
//  RegioneCollectionViewCell.swift
//  CovidStatsITA
//
//  Created by Matteo Visotto on 24/08/2020.
//  Copyright © 2020 Matteo Visotto. All rights reserved.
//

import UIKit

class RegioneCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "regioneCollectionViewCell"
    
    private let nomeRegione = UILabel()
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
        
        self.addSubview(nomeRegione)
        self.addSubview(nuoviPositivi)
        self.addSubview(nuoviMorti)
        
        nomeRegione.translatesAutoresizingMaskIntoConstraints = false
        nuoviPositivi.translatesAutoresizingMaskIntoConstraints = false
        nuoviMorti.translatesAutoresizingMaskIntoConstraints = false
        
        nomeRegione.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        nuoviPositivi.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        nuoviMorti.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        
        nomeRegione.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        nuoviPositivi.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        nuoviMorti.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        
        nomeRegione.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        nuoviPositivi.topAnchor.constraint(equalTo: nomeRegione.bottomAnchor, constant: 10).isActive = true
        nuoviMorti.topAnchor.constraint(equalTo: nuoviPositivi.bottomAnchor, constant: 10).isActive = true
        nuoviMorti.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        nuoviPositivi.textAlignment = .right
        nuoviMorti.textAlignment = .right
        
        nomeRegione.font = .boldSystemFont(ofSize: 20)
        nuoviPositivi.font = .boldSystemFont(ofSize: 18)
        nuoviMorti.font = .boldSystemFont(ofSize: 18)
    }
    
    func setRegione(regione: Regione) {
        self.nomeRegione.text = regione.nome
        self.nuoviPositivi.text = "Positivi: +\(regione.getCovidData().last!.nuoviPositivi)"
        self.nuoviMorti.text = "Deceduti: +\(regione.getCovidData().last!.nuoviMorti)"
    }
}
