//
//  Regioni.swift
//  CovidStatsITA
//
//  Created by Matteo Visotto on 23/08/2020.
//  Copyright © 2020 Matteo Visotto. All rights reserved.
//

import Foundation


enum Regioni: Int, CaseIterable {
    case Abruzzo = 13
    case Basilicata = 17
    case Calabria = 18
    case Campania = 15
    case EmiliaRomagna = 8
    case FriuliVeneziaGiulia = 6
    case Lazio = 12
    case Liguria = 7
    case Lombardia = 3
    case Marche = 11
    case Molise = 14
    case Bolzano = 21
    case Trento = 22
    case Piemonte = 1
    case Puglia = 16
    case Sardegna = 20
    case Sicilia = 19
    case Toscana = 9
    case Umbria = 10
    case ValleDAosta = 2
    case Veneto = 5
}
 
class Regione {
    
    static func getRegioneId(regione: Regioni) -> Int{
        return regione.rawValue
    }
    
    static func getRegioneNome(regione: Regioni) -> String{
        switch regione {
        case .Abruzzo:
            return "Abruzzo"
        
        case .Basilicata:
            return "Basilicata"
        case .Calabria:
            return "Calabria"
        case .Campania:
            return "Campania"
        case .EmiliaRomagna:
            return "Emilia-Romagna"
        case .FriuliVeneziaGiulia:
            return "Friuli Venezia Giulia"
        case .Lazio:
            return "Lazio"
        case .Liguria:
            return "Liguria"
        case .Lombardia:
            return "Lombardia"
        case .Marche:
            return "Marche"
        case .Molise:
            return "Molise"
        case .Bolzano:
            return "P.A. Bolzano"
        case .Trento:
            return "P.A. Trento"
        case .Piemonte:
            return "Piemonte"
        case .Puglia:
            return "Puglia"
        case .Sardegna:
            return "Sardegna"
        case .Sicilia:
            return "Sicilia"
        case .Toscana:
            return "Toscana"
        case .Umbria:
            return "Umbria"
        case .ValleDAosta:
            return "Valle d'Aosta"
        case .Veneto:
            return "Veneto"
        }
    }
    
    static func getRegioneById(idRegione: Int) -> Regioni {
        for regione in Regioni.allCases {
            if(idRegione == getRegioneId(regione: regione)){
                return regione
            }
        }
        return .Abruzzo //Impossibile questo caso, regione di default
    }
    
    static func creaRegione(from provinciaId: Int) -> Regione {
        let regione = getRegioneById(idRegione: provinciaId)
        return Regione(regione: regione)
    }
    
    var idRegione: Int!
    var nome: String!
    private var datiRegione: [CovidData] = []
    
    var province: Dictionary<Int,Provincia> = [:]
    
    init(regione: Regioni){
        self.idRegione = regione.rawValue
        self.nome = Regione.getRegioneNome(regione: regione)
    }
    
    public func setCovidData(covidData: [CovidData]){
        self.datiRegione.removeAll()
        self.datiRegione = covidData
    }
    
    public func addCovidData(covidData: CovidData) {
        datiRegione.append(covidData)
    }
    
    public func getCovidData() -> [CovidData] {
        return self.datiRegione
    }
    
    public func getCovidData(forDate: Date) -> CovidData? {
           for d in datiRegione {
               if(Calendar.current.compare(d.date, to: forDate, toGranularity: .day) == .orderedSame  && Calendar.current.compare(d.date, to: forDate, toGranularity: .month) == .orderedSame && Calendar.current.compare(d.date, to: forDate, toGranularity: .year) == .orderedSame){
                   return d
               }
           }
           return nil
}
    
    public func addProvinciaData(data: Dictionary<String, Any>) {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let date = dateFormatter.date(from: data["data"] as! String)!
            let provinciaId = data["codice_provincia"] as! Int
            
        if let provincia = province[provinciaId] {
            provincia.addCovidData(covidData: CovidProvinciaData(date: date, totalePositivi: data["totale_casi"] as! Int, precedente: provincia.getCovidData().last!))
            } else {
                let nomeProvincia = data["denominazione_provincia"] as! String
            let provincia = Provincia(idProvincia: provinciaId, nome: nomeProvincia)
            self.province[provinciaId] = provincia
            provincia.addCovidData(covidData: CovidProvinciaData(date: date, totalePositivi: data["totale_casi"] as! Int, precedente: CovidProvinciaData.zero))
            }
    }
    
    public func getProvinceNomi() -> [String] {
        var data: [String] = []
        for provincia in self.province.values {
            data.append(provincia.nome)
        }
        return data
     }
    
    public func getProvinciaById(idProvincia: Int) -> Provincia?{
        for provincia in province.values {
            if(provincia.idProvincia == idProvincia) {
                return provincia
            }
        }
        return nil
    }
    
    public func getProvinciaCovidData(provincia: Provincia) -> [CovidProvinciaData]{
        return provincia.getCovidData()
    }
    
    public func getProvinciaCovidData(provinciaId: Int) -> [CovidProvinciaData]{
        guard let p = getProvinciaById(idProvincia: provinciaId) else { return [] }
        return p.getCovidData()
    }
    
}
