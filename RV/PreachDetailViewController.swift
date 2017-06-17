//
//  PreachDetailViewController.swift
//  RV
//
//  Created by Matheus Leite on 14/06/17.
//  Copyright © 2017 Wavez. All rights reserved.
//

import UIKit
import FirebaseDatabase

class PreachDetailViewController: UIViewController {

    var preach : palavra! = nil
    let ref = Database.database().reference().child("preaches")
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var durationField: UITextField!
    @IBOutlet weak var timeField: UITextField!
    @IBOutlet weak var preacherField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        verifyEditMode()
    }
    
    func verifyEditMode () {
        if (preach != nil) {
            nameField.text = preach.nome
            durationField.text = preach.duracao
            timeField.text = preach.horario
            preacherField.text = preach.id_lider
            
            //enable save button
            submitButton.setTitle("Salvar", for: .normal)
            navigationItem.title = "Editar Palavra"
            
            //enable delete button
            let deleteItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(delete(sender:)))
            self.navigationItem.rightBarButtonItem = deleteItem
        }
    }
    
    func delete(sender: UIBarButtonItem) {
        //delete
        ref.child(preach.id_palavra).setValue(nil)
        self.close()
    }
    
    @IBAction func submit(_ sender: Any) {
        
        if submitButton.currentTitle! == "Adicionar" {
            self.ref.childByAutoId().setValue(["name": nameField.text!, "duration" : durationField.text!, "time" : timeField.text!, "preacher" : preacherField.text!])
            
            let alert = UIAlertController(title: "Pronto!", message: "Sua pregação foi cadastrada.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .cancel, handler: { (action) in
                self.close()
            }))
            present(alert, animated: true, completion: nil)
        } else {
            //update
            self.ref.child(preach.id_palavra).setValue(["name": nameField.text!,
                                                                 "duration" : durationField.text!,
                                                                 "time" : timeField.text!,
                                                                 "preacher" : preacherField.text!])
            
            let alert = UIAlertController(title: "Pronto!", message: "Sua pregação foi atualizada.", preferredStyle: .alert)
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
