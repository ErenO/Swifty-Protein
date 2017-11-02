//
//  InfoReq.swift
//  swifty_protein
//
//  Created by Eren OZDEK on 10/30/17.
//  Copyright © 2017 Eren OZDEK. All rights reserved.
//

import Foundation
import Alamofire
import SWXMLHash

class InfoReq {
//    var parser: XMLParser!
    
    init() {
//        parser = XMLParser()
    }
    
    func loadXML(of: String, callback:@escaping ((Any) -> Void)) {
        Alamofire.request(self.getPath(with: of)).responseData(completionHandler: { response in
            if response.response?.statusCode == 200 {
                let fileData = String(data: response.data!, encoding: .utf8)
                callback(fileData!)
            }
        })
        
    }
    
    func getPath(with: String) -> String {
        return "http://files.rcsb.org/ligands/view/" + with + ".xml"
    }
    
}
