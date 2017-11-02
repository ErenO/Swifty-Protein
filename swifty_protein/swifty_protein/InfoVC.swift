//
//  InfoVC.swift
//  swifty_protein
//
//  Created by Eren OZDEK on 10/30/17.
//  Copyright © 2017 Eren OZDEK. All rights reserved.
//

import UIKit
import Alamofire
import SWXMLHash

class InfoVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var nbTitle = "033"
    
    @IBOutlet weak var tableview: UITableView!
    var name: String!
    var formula: String!
    var type: String!
    var weight: String!

    override func viewWillAppear(_ animated: Bool) {
        tableview.estimatedRowHeight = 200
        tableview.rowHeight = UITableViewAutomaticDimension
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
            
   /*     nameTxt.text = name
        formulaTxt.text = formula
        typeTxt.text = type
        molWeightTxt.text = weight
        nameTxt.lineBreakMode = .byWordWrapping // notice the 'b' instead of 'B'
        nameTxt.numberOfLines = 0 */
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell") as? InfosTableViewCell {
            if indexPath.row == 0 {
                print("hello")
                cell.textLbl.text = "Name: " + name
            } else if indexPath.row == 1 {
                print("a")
                cell.textLbl.text = "Molecular weight: " + weight
            } else if indexPath.row == 2 {
                print("b")
                cell.textLbl.text = "Type: " + type
            } else if indexPath.row == 3 {
                print("c")
                cell.textLbl.text = "Formula: " + formula
            }
            return cell
        }
        return UITableViewCell()
    }

}


    
