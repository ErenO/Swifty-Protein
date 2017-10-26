//
//  XMLParser.swift
//  swifty_protein
//
//  Created by Eren OZDEK on 10/26/17.
//  Copyright © 2017 Eren OZDEK. All rights reserved.
//


import Foundation
import Alamofire

struct URL {
    static let xml = "http://files.rcsb.org/ligands/view/033"
    static let xmlExtension = ".xml"
}

class RequestXML {

        var parser: XMLParser!
    
        init() {
            parser = XMLParser()
        }
        
        func loadXML(of: String, callback:@escaping ((Any) -> Void)) {
            Alamofire.request(self.getPath(with: of)).responseData(completionHandler: { response in
                if response.response?.statusCode == 200 {
                    let fileData = String(data: response.data!, encoding: .utf8)
                    let myLigand = self.parser.getInfo(name: of, data: fileData!)
                    callback(myLigand)
                }
            })
            
        }
        
        func getPath(with: String) -> String {
//            let firstLetter = String(with.characters.prefix(1))
            return URL.xml + "" + with + URL.xmlExtension
        }
}
