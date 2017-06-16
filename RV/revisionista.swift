//
//  revisionista.swift
//  APP-RV
//
//  Created by Pedro Zanini on 01/06/17.
//  Copyright © 2017 Pedro Zanini. All rights reserved.
//

import Foundation


class revisionista{
    
    let id_revisionista:String
    let nome:String
    let sexo:String
    let equipe:String
    let cpf:String
    let rg:String
    let email:String
    let telefone:String
    let dt_nascimento:String
    let st_chamada:String
    let id_revisao:String
    let id_lider:String
    let quarto:String
    
    required init(id_revisionista:String, nome:String, sexo:String, equipe:String, cpf:String, rg:String, email:String, telefone:String, dt_nascimento:String, st_chamada:String, id_revisao:String, id_lider:String, quarto:String){
        
        self.id_revisionista = id_revisionista
        self.nome = nome
        self.sexo = sexo
        self.equipe = equipe
        self.cpf = cpf
        self.rg = rg
        self.email = email
        self.telefone = telefone
        self.dt_nascimento = dt_nascimento
        self.st_chamada = st_chamada
        self.id_revisao = id_revisao
        self.id_lider = id_lider
        self.quarto = quarto
    }
}
