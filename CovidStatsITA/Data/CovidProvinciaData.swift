//
//  CovidProvinciaData.swift
//  CovidStatsITA
//
//  Created by Matteo Visotto on 23/08/2020.
//  Copyright © 2020 Matteo Visotto. All rights reserved.
//

import Foundation

class CovidProvinciaData {
    
    static let zero = CovidProvinciaData()
    
    var date: Date
    var totalePositivi: Int
    var nuoviPositivi: Int
    
    init() {
        date = Date(timeIntervalSince1970: 1)
        self.totalePositivi = 0
        self.nuoviPositivi = 0
    }
    
    init(date: Date, totalePositivi: Int, precedente: CovidProvinciaData) {
        self.date = date
        self.totalePositivi = totalePositivi
        self.nuoviPositivi = totalePositivi - precedente.totalePositivi
    }
    
    
    
    
}
