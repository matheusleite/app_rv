//
//  FunctionsDetailViewController.swift
//  RV
//
//  Created by Matheus Leite on 14/06/17.
//  Copyright © 2017 Wavez. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FunctionsDetailViewController: UIViewController {

    let ref = Database.database().reference()
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var revisaoField: UITextField!
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    var funcao : funcao! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        verifyEditMode()
    }
    
    func verifyIfIsAdmin() {
        if UserDefaults.standard.bool(forKey: "admin") == false {
            self.navigationItem.rightBarButtonItems = nil
        }
    }
    
    func verifyEditMode () {
        if (funcao != nil) {
            userField.text = funcao.id_lider
            nameField.text = funcao.nome
            revisaoField.text = funcao.id_revisao
            
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
        ref.child(funcao.id_funcao).setValue(nil)
        self.close()
    }

    @IBAction func submit(_ sender: Any) {
        
        if submitButton.currentTitle! == "Adicionar" {
            self.ref.child("functions").childByAutoId().setValue(["name": nameField.text!, "revisao" : revisaoField.text!, "user" : userField.text!])
            
            let alert = UIAlertController(title: "Pronto!", message: "A função foi cadastrada.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .cancel, handler: { (action) in
                self.close()
            }))
            present(alert, animated: true, completion: nil)
        } else {
            self.ref.child(funcao.id_funcao).setValue(["name": nameField.text!,
                                                       "revisao" : revisaoField.text!,
                                                       "user" : userField.text!])
            
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
