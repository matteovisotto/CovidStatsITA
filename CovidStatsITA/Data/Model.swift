//
//  Model.swift
//  CovidStatsITA
//
//  Created by Matteo Visotto on 23/08/2020.
//  Copyright © 2020 Matteo Visotto. All rights reserved.
//

import Foundation

class Model {
    public static let shared: Model = Model()
    
    private var nuovoBollettino: Bool = false
    private var italia: [CovidData] = []
    private var piccoItalia: Int = 0
    
    private var regioni: Dictionary<Int, Regione> = [:]
    
    private init() {}
    
    public func isUpdated() -> Bool {
        return self.nuovoBollettino
    }
    
    public func getItaData() -> [CovidData]{
        return self.italia
    }
    
    public func getRegioni() -> Dictionary<Int,Regione> {
        return self.regioni
    }
    
    public func getRegioniArray() -> [Regione] {
        var reg: [Regione] = []
        for r in self.regioni.values {
            reg.append(r)
        }
        return reg
    }
    
    
    public func getRegioneById(idRegione: Int) -> Regione? {
        if let regione=self.regioni[idRegione] {
            return regione
        }
        return nil
    }
    
    public func setItaData(from dataDictionary: [Dictionary<String,Any>]) {
        self.italia.removeAll()
        for data in dataDictionary {
            let dateFormatter = DateFormatter()
        
            dateFormatter.locale = Calendar.current.locale
            dateFormatter.timeZone = Calendar.current.timeZone
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let date = dateFormatter.date(from: data["data"] as! String)!
            if(self.italia.count==0){
                //Primo elemento
                italia.append(CovidData(date: date,totalePositivi: data["totale_positivi"] as! Int, nuoviPositivi: data["nuovi_positivi"] as! Int, variazionePositivi: data["variazione_totale_positivi"] as! Int, totaleTamponi: data["tamponi"] as! Int, totaleRicoveri: data["ricoverati_con_sintomi"] as! Int, totaleTerapiaIntensiva: data["terapia_intensiva"] as! Int, totaleDimessi: data["dimessi_guariti"] as! Int, totaleDiagnostico: (data["casi_da_sospetto_diagnostico"] as? Int ?? 0), totaleScreening: (data["casi_da_screening"] as? Int ?? 0), totaleMorti: data["deceduti"] as! Int, giornoPrecedente: CovidData.zero))
            } else {
                italia.append(CovidData(date: date,totalePositivi: data["totale_positivi"] as! Int, nuoviPositivi: data["nuovi_positivi"] as! Int, variazionePositivi: data["variazione_totale_positivi"] as! Int, totaleTamponi: data["tamponi"] as! Int, totaleRicoveri: data["ricoverati_con_sintomi"] as! Int, totaleTerapiaIntensiva: data["terapia_intensiva"] as! Int, totaleDimessi: data["dimessi_guariti"] as! Int, totaleDiagnostico: (data["casi_da_sospetto_diagnostico"] as? Int ?? 0), totaleScreening: (data["casi_da_screening"] as? Int ?? 0), totaleMorti: data["deceduti"] as! Int, giornoPrecedente: self.italia.last!))
            }
        }
        if(Calendar.current.compare(italia.last!.date, to: Date(), toGranularity: .day) == .orderedSame && Calendar.current.compare(italia.last!.date, to: Date(), toGranularity: .month) == .orderedSame && Calendar.current.compare(italia.last!.date, to: Date(), toGranularity: .year) == .orderedSame){
            self.nuovoBollettino = true
        }
        calcolaPicco()
    }
    
    public func addNoteToItaData(from dataDictionary: [Dictionary<String,Any>]){
        for data in dataDictionary {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Calendar.current.locale
            dateFormatter.timeZone = Calendar.current.timeZone
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let date = dateFormatter.date(from: data["data"] as! String)!
            for ita in italia {
                if(Calendar.current.compare(date, to: ita.date, toGranularity: .day) == .orderedSame && Calendar.current.compare(date, to: ita.date, toGranularity: .month) == .orderedSame && Calendar.current.compare(date, to: ita.date, toGranularity: .year) == .orderedSame) {
                    ita.note = data["note"] as! String
                }
            }
        }
    }
    
    public func getDateArray() -> [Date] {
        var date: [Date] = []
        for d in italia {
            date.append(d.date)
        }
        return date
    }
    
    public func getItaData(forDate: Date) -> CovidData? {
        for d in italia {
            if(Calendar.current.compare(d.date, to: forDate, toGranularity: .day) == .orderedSame  && Calendar.current.compare(d.date, to: forDate, toGranularity: .month) == .orderedSame && Calendar.current.compare(d.date, to: forDate, toGranularity: .year) == .orderedSame){
                return d
            }
        }
        return nil
    }
    
    public func setRegioniData(from dataDictionary: [Dictionary<String,Any>]) {
        self.regioni.removeAll()
        for data in dataDictionary {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Calendar.current.locale
            dateFormatter.timeZone = Calendar.current.timeZone
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let date = dateFormatter.date(from: data["data"] as! String)!
            let regioneId = data["codice_regione"] as! Int
            if let regioneEsistente = regioni[regioneId] {
                regioneEsistente.addCovidData(covidData: CovidData(date: date,totalePositivi: data["totale_positivi"] as! Int, nuoviPositivi: data["nuovi_positivi"] as! Int, variazionePositivi: data["variazione_totale_positivi"] as! Int, totaleTamponi: data["tamponi"] as! Int, totaleRicoveri: data["ricoverati_con_sintomi"] as! Int, totaleTerapiaIntensiva: data["terapia_intensiva"] as! Int, totaleDimessi: data["dimessi_guariti"] as! Int, totaleDiagnostico: (data["casi_da_sospetto_diagnostico"] as? Int ?? 0), totaleScreening: (data["casi_da_screening"] as? Int ?? 0), totaleMorti: data["deceduti"] as! Int, giornoPrecedente: regioneEsistente.getCovidData().last!))
            } else {
                let regione = Regione.creaRegione(from: regioneId)
                self.regioni[regioneId] = regione
                regione.addCovidData(covidData: CovidData(date: date,totalePositivi: data["totale_positivi"] as! Int, nuoviPositivi: data["nuovi_positivi"] as! Int, variazionePositivi: data["variazione_totale_positivi"] as! Int, totaleTamponi: data["tamponi"] as! Int, totaleRicoveri: data["ricoverati_con_sintomi"] as! Int, totaleTerapiaIntensiva: data["terapia_intensiva"] as! Int, totaleDimessi: data["dimessi_guariti"] as! Int, totaleDiagnostico: (data["casi_da_sospetto_diagnostico"] as? Int ?? 0), totaleScreening: (data["casi_da_screening"] as? Int ?? 0), totaleMorti: data["deceduti"] as! Int, giornoPrecedente: CovidData.zero))
            }
        }
    }
    
    public func setProvinceData(from dataDictionary: [Dictionary<String,Any>]) {
        for data in dataDictionary {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Calendar.current.locale
            dateFormatter.timeZone = Calendar.current.timeZone
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            _ = dateFormatter.date(from: data["data"] as! String)!
            let regioneId = data["codice_regione"] as! Int
            if let regione = self.regioni[regioneId] {
                regione.addProvinciaData(data: data)
            }
        }
    }
    
    private func calcolaPicco() {
        var picco = 0
        for value in italia {
            if(value.nuoviPositivi > picco){
                picco = value.nuoviPositivi
            }
        }
        piccoItalia = picco
    }
    
    public func getItaPicco() -> Int {
        return self.piccoItalia
    }
}
