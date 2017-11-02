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
    
    @IBOutlet weak var myScrollView: UIScrollView!
    
    @IBOutlet weak var viewInScrollView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
            
        nameTxt.text = name
        formulaTxt.text = formula
        typeTxt.text = type
        molWeightTxt.text = weight
        nameTxt.lineBreakMode = .byWordWrapping // notice the 'b' instead of 'B'
        nameTxt.numberOfLines = 0
    }

}


    
