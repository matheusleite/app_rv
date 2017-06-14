//
//  funcao.swift
//  APP-RV
//
//  Created by Pedro Zanini on 14/06/17.
//  Copyright © 2017 Pedro Zanini. All rights reserved.
//

import Foundation

class funcao {
    
    let id_funcao:String
    let nome:String
    let id_revisao:String
    let id_lider:String
    
    init(id_funcao:String, nome:String, id_revisao:String, id_lider:String) {
        
        self.id_funcao = id_funcao
        self.nome = nome
        self.id_revisao = id_revisao
        self.id_lider = id_lider
    }
}
