//
//  ProteinDisplayVC.swift
//  swifty_protein
//
//  Created by Eren OZDEK on 10/24/17.
//  Copyright © 2017 Eren OZDEK. All rights reserved.
//

import UIKit

class ProteinDisplayVC: UIViewController {

    var proteinToDisplay: String!
    
    @IBOutlet weak var protLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.protLbl.text = proteinToDisplay
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
