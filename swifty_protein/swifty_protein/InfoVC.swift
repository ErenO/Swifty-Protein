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

class InfoVC: UIViewController {

    var nbTitle = "033"
    
    var name: String!
    var formula: String!
    var type: String!
    var weight: String!
    @IBOutlet weak var nameTxt: UILabel!
    @IBOutlet weak var formulaTxt: UILabel!
    @IBOutlet weak var typeTxt: UILabel!
    @IBOutlet weak var molWeightTxt: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTxt.text = name
        formulaTxt.text = formula
        typeTxt.text = type
        molWeightTxt.text = weight
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


    
