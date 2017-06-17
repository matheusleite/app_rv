//
//  LoginViewController.swift
//  RV
//
//  Created by Matheus Leite on 29/05/17.
//  Copyright © 2017 Wavez. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        loginBtn.layer.cornerRadius = 5
        loginBtn.layer.borderColor = UIColor.white.cgColor
        loginBtn.layer.borderWidth = 1
    }
    
    @IBAction func signIn(_ sender: Any) {
        performSegue(withIdentifier: "signIn", sender: nil)
        if (passwordField.text == "admin" && usernameField.text == "coordenador@rv.com") {
            
            UserDefaults.standard.set(true, forKey: "admin")
            performSegue(withIdentifier: "signIn", sender: nil)
        } else if (passwordField.text == "teste123" && usernameField.text == "usuario@rv.com") {
            
            UserDefaults.standard.set(false, forKey: "admin")
            performSegue(withIdentifier: "signIn", sender: nil)
        }
    }
}
