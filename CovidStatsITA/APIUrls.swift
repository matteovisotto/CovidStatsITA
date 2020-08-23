//
//  APIUrls.swift
//  CovidStatsITA
//
//  Created by Matteo Visotto on 23/08/2020.
//  Copyright © 2020 Matteo Visotto. All rights reserved.
//

import Foundation

enum APIUrlsType: String {
    case italiaLatest = "dpc-covid19-ita-andamento-nazionale-latest.json"
    case italia = "dpc-covid19-ita-andamento-nazionale.json"
    case regioniLatest = "dpc-covid19-ita-regioni-latest.json"
    case regioni = "dpc-covid19-ita-regioni.json"
    case provinceLatest = "dpc-covid19-ita-province-latest.json"
    case province = "dpc-covid19-ita-province.json"
    case note = "dpc-covid19-ita-note.json"
}

class APIUrls {
    private static let baseURL = "https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/"
    
    public static func getUrl(forApiType: APIUrlsType) -> String{
        return self.baseURL + forApiType.rawValue
    }
}
