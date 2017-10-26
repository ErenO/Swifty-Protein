//
//  InfoViewController.swift
//  swifty_protein
//
//  Created by Eren OZDEK on 10/26/17.
//  Copyright © 2017 Eren OZDEK. All rights reserved.
//

import UIKit
import SWXLHash

class InfoViewController: UIViewController {

    var reqXML = RequestXML!
    var protInfo: Infos!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reqXML = RequestXML()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getInfo() {
        RequestXML.loadXML(of: "033") { response in
            print ("callback")
            if let infos = response as? Infos {
                self.protInfo = Infos
            }
        }
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
