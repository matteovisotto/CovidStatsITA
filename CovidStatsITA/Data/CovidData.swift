//
//  ItaData.swift
//  CovidStatsITA
//
//  Created by Matteo Visotto on 23/08/2020.
//  Copyright © 2020 Matteo Visotto. All rights reserved.
//

import Foundation

class CovidData {
    
    static let zero = CovidData()
    var date: Date
    var totalePositivi: Int
    var nuoviPositivi: Int
    var variazionePositivi: Int
    var totaleTerapiaIntensiva: Int
    var nuoviTerapiaIntensiva: Int
    var totaleTamponi: Int
    var nuoviTamponi: Int
    var totaleRicoverati: Int
    var nuoviRicoverati: Int
    var totaleDimessi: Int
    var nuoviDimessi: Int
    var totaleDiagnostico: Int
    var nuoviDiagnostico: Int
    var totaleScreening: Int
    var nuoviScreening: Int
    var totaleMorti: Int
    var nuoviMorti: Int
    var note: String = String()
 
    init() {
        date = Date(timeIntervalSince1970: 1)
        totalePositivi = 0
        nuoviPositivi = 0
        variazionePositivi = 0
        totaleTerapiaIntensiva = 0
        nuoviTerapiaIntensiva = 0
        totalePositivi = 0
        totaleTamponi = 0
        nuoviTamponi = 0
        totaleRicoverati = 0
        nuoviRicoverati = 0
        totaleDimessi = 0
        nuoviDimessi = 0
        totaleDiagnostico = 0
        nuoviDiagnostico = 0
        totaleScreening = 0
        nuoviScreening = 0
        totaleMorti = 0
        nuoviMorti = 0
    }
    
    init(date: Date, totalePositivi: Int, nuoviPositivi: Int, variazionePositivi: Int, totaleTamponi: Int, totaleRicoveri:Int, totaleTerapiaIntensiva: Int, totaleDimessi: Int, totaleDiagnostico: Int, totaleScreening: Int, totaleMorti: Int, giornoPrecedente: CovidData) {
        self.date = date
        self.totalePositivi = totalePositivi
        self.nuoviPositivi = nuoviPositivi
        self.variazionePositivi = variazionePositivi
        self.totaleTamponi = totaleTamponi
        self.nuoviTamponi = totaleTamponi - giornoPrecedente.totaleTamponi
        self.totaleTerapiaIntensiva = totaleTerapiaIntensiva
        self.nuoviTerapiaIntensiva = totaleTerapiaIntensiva - giornoPrecedente.totaleTerapiaIntensiva
        self.totaleDimessi = totaleDimessi
        self.nuoviDimessi = totaleDimessi - giornoPrecedente.totaleDimessi
        self.totaleDiagnostico = totaleDiagnostico
        self.nuoviDiagnostico = totaleDiagnostico - giornoPrecedente.totaleDiagnostico
        self.totaleScreening = totaleScreening
        self.nuoviScreening = totaleScreening - giornoPrecedente.totaleScreening
        self.totaleMorti = totaleMorti
        self.nuoviMorti = totaleMorti - giornoPrecedente.totaleMorti
        self.totaleRicoverati = totaleRicoveri
        self.nuoviRicoverati = totaleRicoveri - giornoPrecedente.totaleRicoverati
    }
    
}
