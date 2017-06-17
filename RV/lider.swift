//
//  usuario.swift
//  APP-RV
//
//  Created by Pedro Zanini on 01/06/17.
//  Copyright © 2017 Pedro Zanini. All rights reserved.
//

import Foundation


class lider : Equatable{

    let id_lider:String
    let login:String
    let senha:String
    let coordenador:String
    let avatar:String
    let nome:String
    let id_revisao:String
    let equipe:String
    let quarto:String
    
    
    required init(id_lider:String, login:String, senha:String, coordenador:String, avatar:String, nome:String, id_revisao:String, equipe:String, quarto:String){
        
        self.id_lider = id_lider
        self.login = login
        self.senha = senha
        self.coordenador = coordenador
        self.avatar = avatar
        self.nome = nome
        self.id_revisao = id_revisao
        self.equipe = equipe
        self.quarto = quarto
        
    }
    
    static func ==(lhs:lider, rhs:lider) -> Bool { // Implement Equatable
        return lhs.id_lider == rhs.id_lider
    }
}
