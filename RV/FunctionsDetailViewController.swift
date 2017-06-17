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

    var RVTypes =  [String]()
    let ref = Database.database().reference()
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var revisaoField: UITextField!
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    var funcao : funcao! = nil
    var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        verifyEditMode()
        
        pickerView.delegate = self
        revisaoField.inputView = pickerView
        getRVTypes()
    }
    
    func getRVTypes () {
        let reference = Database.database().reference().child("revisions")
        reference.observe(.childAdded, with: { (snapshot) -> Void in
            let userData = snapshot.value as! Dictionary<String, AnyObject>
            
            self.RVTypes.append(userData["nome"] as! String )
            
        }) { (error) in
            print(error.localizedDescription)
        }
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


extension FunctionsDetailViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1 }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return RVTypes.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return RVTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        revisaoField.text = RVTypes[row]
    }
}
