//
//  FilterTableViewController.swift
//  RV
//
//  Created by Matheus Leite on 12/06/17.
//  Copyright © 2017 Wavez. All rights reserved.
//

import UIKit

class FilterTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let strd = UserDefaults.standard
        //deselect all
        
        switch cell?.reuseIdentifier {
        case "WOMAN_U21"?:
            strd.set("WOMAN_U21", forKey: "rv_type")
            break
        case "WOMAN_O21"?:
            strd.set("WOMAN_O21", forKey: "rv_type")
            break
        case "MAN_U21"?:
            strd.set("MAN_U21", forKey: "rv_type")
            break
        case "MAN_O21"?:
            strd.set("MAN_O21", forKey: "rv_type")
            break
        default:
            break
        }
        
        cell?.accessoryType = .checkmark
        dismiss(animated: true, completion: nil)
    }

}
