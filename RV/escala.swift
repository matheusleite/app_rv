//
//  escala.swift
//  APP-RV
//
//  Created by Pedro Zanini on 14/06/17.
//  Copyright © 2017 Pedro Zanini. All rights reserved.
//

import Foundation

class escala{
    
    let id_escala:String
    let nome:String
    let tipo:String
    let horario: String
    let id_revisao:String
    
    init(id_escala:String, nome:String, tipo:String, horario:String, id_revisao:String) {
        
        self.id_escala = id_escala
        self.nome = nome
        self.tipo = tipo
        self.horario = horario
        self.id_revisao = id_revisao
        
    }
}
