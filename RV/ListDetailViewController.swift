//
//  ListDetailViewController.swift
//  RV
//
//  Created by Matheus Leite on 14/06/17.
//  Copyright © 2017 Wavez. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ListDetailViewController: UIViewController {

    let ref = Database.database().reference()
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var durationField: UITextField!
    @IBOutlet weak var timeField: UITextField!
    @IBOutlet weak var preacherField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func submit(_ sender: Any) {
        self.ref.child("preaches").childByAutoId().setValue(["name": nameField.text!, "duration" : durationField.text!, "time" : timeField.text!, "preacher" : preacherField.text!])
        
        let alert = UIAlertController(title: "Pronto!", message: "Sua pregação foi cadastrada.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK!", style: .cancel, handler: { (action) in
            self.close()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func close () {
        self.navigationController?.popToRootViewController(animated: true)
    }

}
