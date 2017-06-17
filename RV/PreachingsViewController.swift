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
        verifyIfIsAdmin()
    }
    
    deinit {
        ref.removeAllObservers()
    }
    
    func verifyIfIsAdmin() {
        if UserDefaults.standard.bool(forKey: "admin") == false {
            self.navigationItem.rightBarButtonItems = nil
        }
    }
    
    //esse metodo carrega os dados fake
    func loadData () {
        self.ref.observe(.childAdded, with: { (snapshot) -> Void in
            let userData = snapshot.value as! Dictionary<String, AnyObject>
            print(userData["preacher"] as! String!)
            let preach = palavra(id_palavra: snapshot.key,
                                 id_revisao: userData["id_revisao"] as! String!,
                                 id_lider: userData["preacher"] as! String!,
                                 nome: userData["name"] as! String!,
                                 horario: userData["time"] as! String!, duracao: userData["duration"] as! String!)
            self.data.append(preach)
            self.tableView.reloadData()
        })
        //remove()
    }
    
    func remove () {
        self.ref.observe(.childAdded, with: { (snapshot) -> Void in
            let userData = snapshot.value as! Dictionary<String, AnyObject>
            print(userData["preacher"] as! String!)
        })
    }
    
    @IBAction func filter(_ sender: Any) {
        
        let nav = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "filterVC")
        present(nav, animated: true, completion: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        verifyFilter()
    }
    
    func verifyFilter () {
        if let rvType = UserDefaults.standard.string(forKey: "rv_type") {
            if data.count > 0 {
                let aux = data.filter({ ($0.id_revisao == rvType)})
                data = aux
                tableView.reloadData()
            }
        }
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0 {
            //limpo o array
            data.removeAll()
            
            //recarregando dados
            loadData()
        } else {
            //filtrando array
            var aux = [palavra]()
            aux = data.filter({ ($0.id_lider == "Miss. Pedro Zanini")})
            data = aux
            
            //reload na table view
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "preach_detail" {
            let vc = segue.destination as! PreachDetailViewController
            
            if let preach = sender as? palavra {
                vc.preach = preach
            }
        }
    }
}

extension PreachingsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "preachCell", for: indexPath) as! PreachCell
        
        //alimentando a celula atraves dos dados do array
        cell.time.text = data[indexPath.row].horario
        cell.userName.text = data[indexPath.row].id_lider
        cell.title.text = data[indexPath.row].nome
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "preach_detail", sender: data[indexPath.row])
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

