//
//  ProteinTableViewController.swift
//  swifty_protein
//
//  Created by Patricio GUZMAN on 10/24/17.
//  Copyright © 2017 Eren OZDEK. All rights reserved.
//

import UIKit

class ProteinTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var tableview: UITableView!
    var proteinList: [String]!
    var i = 0
    var textSelected: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let session = UserDefaults.standard
        
        proteinList = session.array(forKey: "ligands") as? [String]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return proteinList?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "proteinCell") as? ProteinTableViewCell {
            cell.name.text = self.proteinList?[indexPath.row] ?? "default"
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("i selected a row")
        self.textSelected = self.proteinList[indexPath.row]
        self.performSegue(withIdentifier: "TableToProtein", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableToProtein" {
            if let nbTitle = self.textSelected {
                print("i clicked over \(nbTitle)")
                if let vc = segue.destination as? ProteinViewController {
                    vc.proteinToDisplay = nbTitle
                }
            }
        }
    }
}
