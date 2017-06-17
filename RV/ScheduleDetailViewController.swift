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

    var times =  ["08:00", "09:00"]
    var types =  ["Tenda", "Cozinha", "Intercessão", "Banheiros"]
    var array =  [String]()
    let ref = Database.database().reference().child("scales")
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var timeField: UITextField!
    @IBOutlet weak var revisaoField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    var escala : escala! = nil
    var pickerView = UIPickerView()
    var selectedField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.verifyEditMode()
        pickerView.delegate = self
        
        revisaoField.inputView = pickerView
        typeField.inputView = pickerView
        timeField.inputView = pickerView
        
        revisaoField.delegate = self
        typeField.delegate = self
        timeField.delegate = self
        getRVTypes()
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
    
    func getRVTypes () {
        let reference = Database.database().reference().child("revisions")
        reference.observe(.childAdded, with: { (snapshot) -> Void in
            let userData = snapshot.value as! Dictionary<String, AnyObject>
            
            self.array.append(userData["nome"] as! String )
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }

}

extension ScheduleDetailViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1 }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch selectedField {
        case revisaoField:
            return array.count
        case typeField:
            return types.count
        case timeField:
            return times.count
        default :
            return 0
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch selectedField {
        case revisaoField:
            return array[row]
        case typeField:
            return types[row]
        case timeField:
            return times[row]
        default :
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch selectedField {
        case revisaoField:
            revisaoField.text = array[row]
            break
        case typeField:
            typeField.text = types[row]
            break
        case timeField:
            timeField.text = times[row]
            break
        default :
            break
        }
    }
}

extension ScheduleDetailViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case revisaoField:
            selectedField = revisaoField
            break
        case typeField:
            selectedField = typeField
            break
        case timeField:
            selectedField = timeField
            break
        default:
            break
        }
        
        pickerView.reloadAllComponents()
    }
    
}
