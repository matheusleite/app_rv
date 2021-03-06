//
//  ScheduleViewController.swift
//  RV
//
//  Created by Matheus Leite on 12/06/17.
//  Copyright © 2017 Wavez. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ScheduleViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var data = [escala]()
    var dataFixa = [escala]()
    let ref = Database.database().reference().child("scales")
    
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
        
        
        switch segmentedControl.selectedSegmentIndex {
        
        case 0:
            data.removeAll()
            data = dataFixa
            var aux = [escala]()
            aux = data.filter({($0.tipo == "Tenda")})
            data = aux
            
        
        case 1:
            data.removeAll()
            data = dataFixa
            var aux = [escala]()
            aux = data.filter({($0.tipo == "Cozinha")})
            data = aux
            
            
        case 2:
            data.removeAll()
            data = dataFixa
            var aux = [escala]()
            aux = data.filter({($0.tipo == "Intercessão")})
            data = aux
           
            
        case 3:
            data.removeAll()
            data = dataFixa
            var aux = [escala]()
            aux = data.filter({($0.tipo == "Banheiros")})
            data = aux
            
            
        default: break
        
        }
        
        tableView.reloadData()
    }
    
    func loadData () {
        self.ref.observe(.childAdded, with: { (snapshot) -> Void in
            let userData = snapshot.value as! Dictionary<String, AnyObject>
            
            let schedule = escala(id_escala: snapshot.key,
                                  nome: userData["user"] as! String!,
                                  tipo: userData["type"] as! String!,
                                  horario: userData["time"] as! String!,
                                  id_revisao: userData["revisao"] as! String!)
            if schedule.tipo == "Tenda" {
             self.data.append(schedule)   
            }
            self.dataFixa.append(schedule)
            self.tableView.reloadData()
        })
    }
    
    @IBAction func filter(_ sender: Any) {
        let nav = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "filterVC")
        present(nav, animated: true, completion: nil) 
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "schedule_detail" {
            let vc = segue.destination as! ScheduleDetailViewController
            
            if let escala = sender as? escala {
                vc.escala = escala
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "schedule_detail", sender: data[indexPath.row])
    }

}

extension ScheduleViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as! ScheduleTableViewCell
        
        cell.timeLabel.text = data[indexPath.row].horario
        cell.nameLabel.text = data[indexPath.row].nome
        
        return cell
        
    }
}

extension ScheduleViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
}

