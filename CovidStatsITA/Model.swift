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
    
    private init() {}
    
    public func isUpdated() -> Bool {
        return self.nuovoBollettino
    }
    
    public func getItaData() -> [CovidData]{
        return self.italia
    }
    
    public func setItaData(from dataDictionary: [Dictionary<String,Any>]) {
        self.italia.removeAll()
        for data in dataDictionary {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
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
