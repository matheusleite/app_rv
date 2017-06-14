//
//  PreachingsViewController.swift
//  RV
//
//  Created by Matheus Leite on 29/05/17.
//  Copyright © 2017 Wavez. All rights reserved.
//

//estruturas simples para criar dados fake
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
    var data = [Preach]() //array onde ficará os dados fake e alimentará a tableView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadData()
    }
    
    //esse metodo carrega os dados fake
    func loadData () {
        let u1 = User(name: "Ms. Pedro Zanini", email: "pedrovzg@gmail.com")
        let u2 = User(name: "Bp. Raphael Assunção", email: "bprapha@gmail.com")
        
        let p1 = Preach(description: "Bom dia, o que desejas?", user: u1, time: "08:30")
        let p2 = Preach(description: "A Bíblia", user: u2, time: "10:10")
        let p3 = Preach(description: "O Verdadeiro Herói", user: u1, time: "10:50")
        let p4 = Preach(description: "Perdão e Família", user: u1, time: "17:00")
        
        data.append(p1)
        data.append(p2)
        data.append(p3)
        data.append(p4)
        
        tableView.reloadData()
    }
    
    @IBAction func filter(_ sender: Any) {
        
        let nav = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "filterVC")
        present(nav, animated: true, completion: nil)
        
    }
    @IBAction func segmentChanged(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0 {
            //limpo o array
            data.removeAll()
            
            //recarregando dados
            loadData()
        } else {
            //filtrando array
            var aux = [Preach]()
            aux = data.filter({ ($0.user.name == "Ms. Pedro Zanini")})
            data = aux
            
            //reload na table view
            tableView.reloadData()
        }
    }
}



extension PreachingsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "preachCell", for: indexPath) as! PreachCell
        
        
        //alimentando a celula atraves dos dados do array
        cell.time.text = data[indexPath.row].time
        cell.userName.text = data[indexPath.row].user.name
        cell.title.text = data[indexPath.row].description
        
        return cell
        
    }
}

extension PreachingsViewController : UITableViewDataSource {
    
    //numero de seções da table
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //numero de linhas da table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
}

