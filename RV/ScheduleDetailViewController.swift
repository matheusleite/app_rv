//
//  ScheduleDetailViewController.swift
//  RV
//
//  Created by Matheus Leite on 14/06/17.
//  Copyright © 2017 Wavez. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ScheduleDetailViewController: UIViewController {

    let ref = Database.database().reference().child("scales")
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var timeField: UITextField!
    @IBOutlet weak var revisaoField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    var escala : escala! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.verifyEditMode()
    }
    
    func verifyEditMode () {
        if (escala != nil) {
            userField.text = escala.nome
            typeField.text = escala.tipo
            timeField.text = escala.horario
            revisaoField.text = escala.id_revisao
            
            //enable save button
            submitButton.setTitle("Salvar", for: .normal)
            navigationItem.title = "Editar Escala"
            
            //enable delete button
            let deleteItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(delete(sender:)))
            self.navigationItem.rightBarButtonItem = deleteItem
        }
    }
    
    func delete(sender: UIBarButtonItem) {
        //delete
        ref.child(escala.id_escala).setValue(nil)
        self.close()
    }
    
    @IBAction func submit(_ sender: Any) {
        //todo save/update
        
        if submitButton.currentTitle! == "Adicionar" {
            self.ref.childByAutoId().setValue(["user": userField.text!, "type" : typeField.text!, "time" : timeField.text!, "revisao" : revisaoField.text!])
            
            let alert = UIAlertController(title: "Pronto!", message: "Sua escala foi cadastrada.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .cancel, handler: { (action) in
                self.close()
            }))
            present(alert, animated: true, completion: nil)
            
        } else {
            self.ref.child(escala.id_escala).setValue(["usuario": userField.text!,
                                                        "tipo" : typeField.text!,
                                                        "nome" : timeField.text!,
                                                        "revisao" : revisaoField.text!])
            
            let alert = UIAlertController(title: "Pronto!", message: "Sua escala foi atualizada.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .cancel, handler: { (action) in
                self.close()
            }))
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    
    func close () {
        self.navigationController?.popToRootViewController(animated: true)
    }

}
