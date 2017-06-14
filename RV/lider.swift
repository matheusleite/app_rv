//
//  usuario.swift
//  APP-RV
//
//  Created by Pedro Zanini on 01/06/17.
//  Copyright © 2017 Pedro Zanini. All rights reserved.
//

import Foundation


class lider{

    
    let login:String
    let senha:String
    let coordenador:String
    let avatar:String
    let nome:String
    let sobrenome:String
    let id_revisao:String
    
    init(login:String, senha:String, coordenador:String, avatar:String, nome:String, sobrenome:String, id_revisao:String){
        
        self.login = login
        self.senha = senha
        self.coordenador = coordenador
        self.avatar = avatar
        self.nome = nome
        self.sobrenome = sobrenome
        self.id_revisao = id_revisao
        
    }
}
