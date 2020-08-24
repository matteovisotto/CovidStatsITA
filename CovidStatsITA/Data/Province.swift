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
    
    init(idProvincia: Int, nome: String) {
        self.idProvincia = idProvincia
        self.nome = nome
    }
}
