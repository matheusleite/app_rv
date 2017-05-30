//
//  PreachingsViewController.swift
//  RV
//
//  Created by Matheus Leite on 29/05/17.
//  Copyright © 2017 Wavez. All rights reserved.
//

struct User {
    var name : String!
    var email : String!
}

struct Preach {
    var description : String!
    var user : User!
    var time : String!
}


import UIKit

class PreachingsViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var data = [Preach]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadData()
    }
    
    func loadData () {
        let u1 = User(name: "Ms. Pedro Zanini", email: "pedrovzg@gmail.com")
        let u2 = User(name: "Bp. Raphael Assunção", email: "bprapha@gmail.com")
        
        let p1 = Preach(description: "Palavra de Deus", user: u1, time: "14:00")
        let p2 = Preach(description: "Palavra de Deus", user: u2, time: "14:00")
        let p3 = Preach(description: "Palavra de Deus", user: u2, time: "14:00")
        let p4 = Preach(description: "Palavra de Deus", user: u1, time: "14:00")
        
        data.append(p1)
        data.append(p2)
        data.append(p3)
        data.append(p4)
        
        tableView.reloadData()
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 1 {
            //all preachs
            data.removeAll()
            loadData()
        } else {
            //only my preachs
            var aux = [Preach]()
            aux = data.filter({ ($0.user.name == "Ms. Pedro Zanini")})
            data = aux
            tableView.reloadData()
        }
    }
}

extension PreachingsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "preachCell", for: indexPath) as! PreachCell
        
        cell.time.text = data[indexPath.row].time
        cell.userName.text = data[indexPath.row].user.name
        cell.title.text = data[indexPath.row].description
        
        return cell
        
    }
}

extension PreachingsViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
}

