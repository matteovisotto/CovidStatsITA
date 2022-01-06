//
//  DataCollectionViewCell.swift
//  CovidStatsITA
//
//  Created by Matteo Visotto on 23/08/2020.
//  Copyright © 2020 Matteo Visotto. All rights reserved.
//

import UIKit

enum DataCollectionViewCellType {
    case tamponi
    case morti
    case ricoveri
    case dimessi
    case terapieIntensive
    case screening
    case diagnostico
    case positivi
    
}

class DataCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "dataCollectionViewCell"
    
    private let dataTitle = UILabel()
    private let dataValue = UILabel()
    private let dataDelta = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        if #available(iOS 13.0, *) {
                   self.backgroundColor = .systemBackground
               } else {
                   self.backgroundColor = .white
               }
        self.layer.cornerRadius = 10
        addSubview(dataTitle)
        addSubview(dataValue)
        addSubview(dataDelta)
        
        dataTitle.translatesAutoresizingMaskIntoConstraints = false
        dataValue.translatesAutoresizingMaskIntoConstraints = false
        dataDelta.translatesAutoresizingMaskIntoConstraints = false
        
        dataTitle.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        dataTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        dataTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        
        dataValue.topAnchor.constraint(equalTo: dataTitle.bottomAnchor, constant: 5).isActive = true
        dataValue.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        dataValue.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        
        dataDelta.topAnchor.constraint(equalTo: dataValue.bottomAnchor, constant: 5).isActive = true
        dataDelta.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        dataDelta.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        dataDelta.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        dataTitle.font = .boldSystemFont(ofSize: 20)
        dataValue.font = .boldSystemFont(ofSize: 18)
        dataDelta.font = .boldSystemFont(ofSize: 18)
        
        dataTitle.numberOfLines = .zero
        
        dataValue.textAlignment = .center
        dataDelta.textAlignment = .center
        
        self.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.5
    }
    
    public func setData(itaData: CovidData, cellType: DataCollectionViewCellType){
        switch cellType {
        case .positivi:
            dataTitle.text = "Positivi"
            dataValue.text = "\(itaData.totalePositivi)"
            
            if(itaData.variazionePositivi > 0) {
                dataDelta.textColor = .red
                dataDelta.text = "+\(itaData.variazionePositivi)"
            } else {
                dataDelta.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                dataDelta.text = "-\(itaData.variazionePositivi)"
            }
            break
            
        case .morti:
            dataTitle.text = "Deceduti"
            dataValue.text = "\(itaData.totaleMorti)"
            
            if(itaData.nuoviMorti > 0) {
                dataDelta.textColor = .red
                dataDelta.text = "+\(itaData.nuoviMorti)"
            } else {
                dataDelta.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                dataDelta.text = "\(itaData.nuoviMorti)"
            }
            break
        case .tamponi:
            dataTitle.text = "Tamponi"
            dataValue.text = "\(itaData.totaleTamponi)"
            dataDelta.text = "+\(itaData.nuoviTamponi)"
            dataDelta.textColor = #colorLiteral(red: 0, green: 0.4213759899, blue: 0.9376491308, alpha: 1)
            break
        case .ricoveri:
            dataTitle.text = "Ricoverati"
            dataValue.text = "\(itaData.totaleRicoverati)"
            
            if(itaData.nuoviRicoverati > 0) {
                dataDelta.textColor = .red
                dataDelta.text = "+\(itaData.nuoviRicoverati)"
            } else {
                dataDelta.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                dataDelta.text = "\(itaData.nuoviRicoverati)"
            }
            break
        case .dimessi:
            dataTitle.text = "Dimessi"
            dataValue.text = "\(itaData.totaleDimessi)"
            dataDelta.text = "+\(itaData.nuoviDimessi)"
            dataDelta.textColor = #colorLiteral(red: 0, green: 0.4213759899, blue: 0.9376491308, alpha: 1)
            break
        case .terapieIntensive:
             dataTitle.text = "Terapia Intensiva"
            dataValue.text = "\(itaData.totaleTerapiaIntensiva)"
                       
            if(itaData.nuoviTerapiaIntensiva > 0) {
                dataDelta.textColor = .red
                dataDelta.text = "+\(itaData.nuoviTerapiaIntensiva)"
            } else {
                dataDelta.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                dataDelta.text = "\(itaData.nuoviTerapiaIntensiva)"
            }
            break
        case .screening:
            dataTitle.text = "Da screening"
            dataValue.text = "\(itaData.totaleScreening)"
            dataDelta.text = "+\(itaData.nuoviScreening)"
            dataDelta.textColor = #colorLiteral(red: 0, green: 0.4213759899, blue: 0.9376491308, alpha: 1)
            break
        case .diagnostico:
            dataTitle.text = "Da diagnosi"
            dataValue.text = "\(itaData.totaleDiagnostico)"
            dataDelta.text = "+\(itaData.nuoviDiagnostico)"
            dataDelta.textColor = #colorLiteral(red: 0, green: 0.4213759899, blue: 0.9376491308, alpha: 1)
            break
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dataDelta.textColor = #colorLiteral(red: 0, green: 0.4213759899, blue: 0.9376491308, alpha: 1)
    }
}
