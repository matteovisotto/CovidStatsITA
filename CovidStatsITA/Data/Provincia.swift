//
//  Province.swift
//  CovidStatsITA
//
//  Created by Matteo Visotto on 23/08/2020.
//  Copyright © 2020 Matteo Visotto. All rights reserved.
//

import Foundation

class Provincia {
    
    var idProvincia: Int!
    var nome: String!
    private var covidData: [CovidProvinciaData] = []
    
    init(idProvincia: Int, nome: String) {
        self.idProvincia = idProvincia
        self.nome = nome
    }
    
    func setCovidData(covidData: [CovidProvinciaData]) {
        self.covidData.removeAll()
        self.covidData = covidData
    }
    
    func addCovidData(covidData: CovidProvinciaData){
        self.covidData.append(covidData)
    }
    
    func getCovidData() -> [CovidProvinciaData] {
        return self.covidData
    }
    public func getCovidData(forDate: Date) -> CovidProvinciaData? {
               for d in covidData {
                   if(Calendar.current.compare(d.date, to: forDate, toGranularity: .day) == .orderedSame  && Calendar.current.compare(d.date, to: forDate, toGranularity: .month) == .orderedSame && Calendar.current.compare(d.date, to: forDate, toGranularity: .year) == .orderedSame){
                       return d
                   }
               }
               return nil
    }
}
