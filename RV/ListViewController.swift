//
//  ListViewController.swift
//  RV
//
//  Created by Matheus Leite on 12/06/17.
//  Copyright © 2017 Wavez. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ListViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var data = [lider]()
    var dataRevisionista = [revisionista]()
    let ref = Database.database().reference().child("leaders")
    let refRevisionista = Database.database().reference().child("revisionistas")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        verifyIfIsAdmin()
        loadData()
        loadDataRevisionista()
        
    }
    
    func verifyIfIsAdmin() {
        if UserDefaults.standard.bool(forKey: "admin") == false {
            self.navigationItem.rightBarButtonItems = nil
        }
    }

    @IBAction func segmentChanged(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0 {
            //all preachs
            
            self.tableView.reloadData()
        } else {
            
            self.tableView.reloadData()
        }
    }
    
    func loadData() {
        self.ref.observe(.childAdded, with: { (snapshot) -> Void in
            let userData = snapshot.value as! Dictionary<String, AnyObject>
            
            let user = lider(id_lider: snapshot.key,
                             login: userData["login"] as! String,
                             senha: userData["senha"] as! String,
                             coordenador: userData["coordenador"] as! String,
                             avatar: userData["avatar"] as! String,
                             nome: userData["nome"] as! String,
                             id_revisao: userData["id_revisao"] as! String,
                             equipe: userData["equipe"] as! String,
                             quarto: userData["quarto"] as! String)
            
            if !self.data.contains(user) {
                self.data.append(user)
                self.tableView.reloadData()
            }
        })
    }
    
    func loadDataRevisionista() {
        self.refRevisionista.observe(.childAdded, with: { (snapshot) -> Void in
            let userData = snapshot.value as! Dictionary<String, AnyObject>
            
            let auxrevisionista = revisionista(
                id_revisionista: snapshot.key,
                nome: userData["nome"] as! String,
                sexo: userData["sexo"] as! String,
                equipe: userData["equipe"] as! String,
                cpf: userData["cpf"] as! String,
                rg: userData["rg"] as! String,
                email: userData["email"] as! String,
                telefone: userData["telefone"] as! String,
                dt_nascimento: userData["dt_nascimento"] as! String,
                st_chamada: userData["st_chamada"] as! String,
                id_revisao: userData["id_revisao"] as! String,
                id_lider: userData["id_lider"] as! String,
                quarto: userData["quarto"] as! String)
            
            
            if !self.dataRevisionista.contains(auxrevisionista) {
                self.dataRevisionista.append(auxrevisionista)
                self.tableView.reloadData()
            }
        })
    }
}


extension ListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListTableViewCell
        
        if segmentedControl.selectedSegmentIndex == 0 {
            
            cell.nameLabel.text = data[indexPath.row].nome
            cell.teamLabel.text = data[indexPath.row].equipe
            cell.roomLabel.text = data[indexPath.row].quarto

        } else {
            
            cell.nameLabel.text = dataRevisionista[indexPath.row].nome
            cell.teamLabel.text = dataRevisionista[indexPath.row].equipe
            cell.roomLabel.text = dataRevisionista[indexPath.row].quarto

        }
        
        
        return cell
        
    }
}

extension ListViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
}
