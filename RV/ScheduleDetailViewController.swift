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

    let ref = Database.database().reference()
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var timeField: UITextField!
    @IBOutlet weak var revisaoField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        verifyIfIsAdmin()
    }
    
    func verifyIfIsAdmin() {
        if UserDefaults.standard.bool(forKey: "admin") == false {
            self.navigationItem.rightBarButtonItems = nil
        }
    }
    
    @IBAction func submit(_ sender: Any) {
        self.ref.child("scales").childByAutoId().setValue(["user": userField.text!, "type" : typeField.text!, "time" : timeField.text!, "revisao" : revisaoField.text!])
        
        let alert = UIAlertController(title: "Pronto!", message: "Sua escala foi cadastrada.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK!", style: .cancel, handler: { (action) in
            self.close()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func close () {
        self.navigationController?.popToRootViewController(animated: true)
    }

}
