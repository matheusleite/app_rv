//
//  FunctionsViewController.swift
//  RV
//
//  Created by Matheus Leite on 12/06/17.
//  Copyright © 2017 Wavez. All rights reserved.
//

import UIKit
import FirebaseDatabase

enum RVType {
    case WOMAN_U21 //womens under 20 years old
    case MAN_U21 //mens under 20 years old
    case WOMAN_O21 //womens over 20 years old
    case MAN_O21 //mens over 20 years old
}

struct Function {
    var type : RVType!
    var user : User!
    var function : String!
}

class FunctionsViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var data = [funcao]()
    let ref = Database.database().reference().child("functions")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadData()
        verifyIfIsAdmin()
    }
    
    func verifyIfIsAdmin() {
        if UserDefaults.standard.bool(forKey: "admin") == false {
            self.navigationItem.rightBarButtonItems = nil
        }
    }

    @IBAction func segmentChanged(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0 {
            //all preachs
            data.removeAll()
            loadData()
        } else {
            //only my preachs
//            var aux = [Function]()
//            aux = data.filter({ ($0.user.name == "Ms. Pedro Zanini")})
//            data = aux
            tableView.reloadData()
        }
    }
    
    func loadData() {
        self.ref.observe(.childAdded, with: { (snapshot) -> Void in
            let userData = snapshot.value as! Dictionary<String, AnyObject>
            
            let function = funcao(id_funcao: snapshot.key,
                                  nome: userData["name"] as! String!,
                                  id_revisao: userData["revisao"] as! String!,
                                  id_lider: userData["user"] as! String!)
            self.data.append(function)
            self.tableView.reloadData()
        })
    }
    
}

extension FunctionsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "funcCell", for: indexPath) as! FunctionsTableViewCell
        
        cell.functionLabel.text = data[indexPath.row].nome
        cell.userNameLabel.text = data[indexPath.row].id_lider
        
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
