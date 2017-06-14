//
//  ScheduleViewController.swift
//  RV
//
//  Created by Matheus Leite on 12/06/17.
//  Copyright © 2017 Wavez. All rights reserved.
//

import UIKit
import FirebaseDatabase

struct Event {
    var type : RVType!
    var user : User!
    var function : String!
    var time : String!
}

class ScheduleViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var data = [escala]()
    let ref = Database.database().reference().child("scales")
    
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
//            var aux = [Event]()
//            aux = data.filter({ ($0.user == "Ms. Pedro Zanini")})
            //data = aux
            tableView.reloadData()
        }
    }
    
    func loadData () {
        self.ref.observe(.childAdded, with: { (snapshot) -> Void in
            let userData = snapshot.value as! Dictionary<String, AnyObject>
            
            let schedule = escala(id_escala: snapshot.key,
                                  nome: userData["user"] as! String!,
                                  tipo: userData["type"] as! String!,
                                  horario: userData["time"] as! String!,
                                  id_revisao: userData["revisao"] as! String!)
            self.data.append(schedule)
            self.tableView.reloadData()
        })
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
