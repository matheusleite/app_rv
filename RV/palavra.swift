//
//  palavra.swift
//  APP-RV
//
//  Created by Pedro Zanini on 05/06/17.
//  Copyright © 2017 Pedro Zanini. All rights reserved.
//

import Foundation

class palavra{
    
    let id_palavra:String
    let id_revisao:String
    let id_lider:String
    let nome:String
    let horario:String
    let duracao:String
   
    
    init(id_palavra:String, id_revisao:String, id_lider:String, nome:String, horario:String, duracao:String){
        
        self.id_palavra = id_palavra
        self.id_revisao = id_revisao
        self.id_lider = id_lider
        self.nome = nome
        self.horario = horario
        self.duracao = duracao
        
        
    }
}
