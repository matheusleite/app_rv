//
//  FunctionsViewController.swift
//  RV
//
//  Created by Matheus Leite on 12/06/17.
//  Copyright © 2017 Wavez. All rights reserved.
//

import UIKit

enum RVType {
    case WOMAN_U20
    case MAN_U20
    case WOMAN_O20
    case MAN_O20
}

struct Function {
    var type : RVType!
    var user : User!
    var function : String!
}

class FunctionsViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var data = [Function]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadData()
    }

    @IBAction func segmentChanged(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0 {
            //all preachs
            data.removeAll()
            loadData()
        } else {
            //only my preachs
            var aux = [Function]()
            aux = data.filter({ ($0.user.name == "Ms. Pedro Zanini")})
            data = aux
            tableView.reloadData()
        }
    }
    
    func loadData() {
        let u1 = User(name: "Ms. Pedro Zanini", email: "pedrovzg@gmail.com")
        let u2 = User(name: "Bp. Raphael Assunção", email: "bprapha@gmail.com")
        
        let obj1 = Function(type: RVType.MAN_U20, user: u1, function: "Coordenação de Tenda")
        let obj2 = Function(type: RVType.MAN_U20, user: u2, function: "Supervisão Revisão")
        
        data.append(obj1)
        data.append(obj2)
        tableView.reloadData()
    }
    
}

extension FunctionsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "funcCell", for: indexPath) as! FunctionsTableViewCell
        
        cell.functionLabel.text = data[indexPath.row].function
        cell.userNameLabel.text = data[indexPath.row].user.name
        
        return cell
        
    }
}

extension FunctionsViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
}
