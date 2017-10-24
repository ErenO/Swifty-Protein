//
//  ProteinTableVC.swift
//  swifty_protein
//
//  Created by Eren OZDEK on 10/24/17.
//  Copyright © 2017 Eren OZDEK. All rights reserved.
//

import UIKit

class ProteinTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    var proteinList: [String]?
    var i = 0
    var textSelected: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let session = UserDefaults.standard
        
        proteinList = session.array(forKey: "ligands") as? [String]
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return proteinList?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProtCell") as? ProteinTableViewCell {
            cell.name.text = self.proteinList?[indexPath.row] ?? ""
//            if ((self.proteinList?[self.i]) != nil) {
//                cell.name.text = self.proteinList?[self.i]
//                self.i += 1
//                return cell
//            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("i selected a row")
        self.textSelected = self.proteinList?[indexPath.row]
        self.performSegue(withIdentifier: "TableToProtein", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableToProtein" {
            if let nbTitle = self.textSelected {
                print("i clicked over \(nbTitle)")
                if let vc = segue.destination as?  ProteinDisplayVC {
//                    print(vc)
                    print("changing the name of the label")
//                    vc.name!.text = nbTitle
//                    print(vc.nameLbl.text!)
                }
            }
        }
    }
}
