//
//  ScheduleViewController.swift
//  RV
//
//  Created by Matheus Leite on 12/06/17.
//  Copyright © 2017 Wavez. All rights reserved.
//

import UIKit

struct Event {
    var type : RVType!
    var user : User!
    var function : String!
    var time : String!
}

class ScheduleViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var data = [Event]()
    
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
            var aux = [Event]()
            aux = data.filter({ ($0.user.name == "Ms. Pedro Zanini")})
            data = aux
            tableView.reloadData()
        }
    }
    
    func loadData() {
//        let u1 = User(name: "Ms. Pedro Zanini", email: "pedrovzg@gmail.com")
//        let u2 = User(name: "Bp. Raphael Assunção", email: "bprapha@gmail.com")
//        
//        let obj1 = Event(type: RVType.MAN_U20, user: u1, function: "Coordenação de Tenda")
//        let obj2 = Event(type: RVType.MAN_U20, user: u2, function: <#T##String!#>, time: <#T##String!#>)
//        
//        data.append(obj1)
//        data.append(obj2)
//        tableView.reloadData()
    }

}

extension ScheduleViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as! ScheduleTableViewCell
        
//        cell.functionLabel.text = data[indexPath.row].function
//        cell.userNameLabel.text = data[indexPath.row].user.name
        
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
