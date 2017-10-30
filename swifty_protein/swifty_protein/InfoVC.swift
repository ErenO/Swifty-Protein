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

    //    var reqXML = RequestXML!
//    var protInfo: Infos!
    var nbTitle = "033"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        reqXML = RequestXML()
        // Do any additional setup after loading the view.
        display()
    }
    
    func display() {
        loadXML(of: nbTitle) { response in
            print("callback")
            print(response)
            response
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadXML(of: String, callback:@escaping ((Any) -> Void)) {
        Alamofire.request(self.getPath(with: of)).responseData(completionHandler: { response in
            if response.response?.statusCode == 200 {
                let fileData = String(data: response.data!, encoding: .utf8)
                //                    let myLigand = self.parser.getInfo(name: of, data: fileData!)
                callback(fileData!)
            }
        })
        
    }
    
    func getPath(with: String) -> String {
        //            let firstLetter = String(with.characters.prefix(1))
        return "http://files.rcsb.org/ligands/view/033.xml"
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
/*
//    var reqXML = RequestXML!
var protInfo: Infos!
var nbTitle = "033"

override func viewDidLoad() {
    super.viewDidLoad()
    //        reqXML = RequestXML()
    // Do any additional setup after loading the view.
    display()
}

func display() {
    loadXML(of: nbTitle) { response in
        print("callback")
        //            print(response)
        let xml = SWXMLHash.config {
            config in
            config.shouldProcessLazily = true
            }.parse(response as! String)
        //            let xml = SWXMLHash.lazy(response)
        print(xml["PDBx:datablock"]["PDBx:chem_compCategory"]["PDBx:chem_comp"]["PDBx:name"].element?.text ?? "merde")
    }
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}

func loadXML(of: String, callback:@escaping ((Any) -> Void)) {
    Alamofire.request(self.getPath(with: of)).responseData(completionHandler: { response in
        if response.response?.statusCode == 200 {
            let fileData = String(data: response.data!, encoding: .utf8)
            //                    let myLigand = self.parser.getInfo(name: of, data: fileData!)
            callback(fileData!)
        }
    })
    
}

func getPath(with: String) -> String {
    //            let firstLetter = String(with.characters.prefix(1))
    return "http://files.rcsb.org/ligands/view/033.xml"
}
    */
