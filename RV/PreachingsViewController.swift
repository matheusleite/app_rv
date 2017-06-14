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
import FirebaseDatabase

class PreachingsViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var data = [palavra]() //array onde ficará os dados fake e alimentará a tableView
    let ref = Database.database().reference().child("preaches")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadData()
    }
    
    //esse metodo carrega os dados fake
    func loadData () {
        self.ref.observe(.childAdded, with: { (snapshot) -> Void in
            let userData = snapshot.value as! Dictionary<String, AnyObject>
            print(userData["preacher"] as! String!)
            let preach = palavra(id_palavra: snapshot.key,
                                 id_revisao: "1",
                                 id_lider: userData["preacher"] as! String!,
                                 nome: userData["preacher"] as! String!,
                                 horario: userData["time"] as! String!, duracao: userData["duration"] as! String!)
            self.data.append(preach)
            self.tableView.reloadData()
        })
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
//            var aux = [Preach]()
//            aux = data.filter({ ($0.user.name == "Ms. Pedro Zanini")})
//            data = aux
            
            //reload na table view
            tableView.reloadData()
        }
    }
}



extension PreachingsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "preachCell", for: indexPath) as! PreachCell
        
        
        //alimentando a celula atraves dos dados do array
        cell.time.text = data[indexPath.row].horario
        cell.userName.text = data[indexPath.row].nome
        cell.title.text = data[indexPath.row].horario
        
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

