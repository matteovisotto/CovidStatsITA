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
        return .Abruzzo
    }
}
