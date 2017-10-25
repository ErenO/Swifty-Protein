//
//  NetworkController.swift
//  swifty_protein
//
//  Created by Patricio GUZMAN on 10/25/17.
//  Copyright © 2017 Eren OZDEK. All rights reserved.
//

import Foundation
import Alamofire

struct URLS {
    static let pdb = "http://ligand-expo.rcsb.org/reports/"
    static let pdbExtension = "_ideal.pdb"
}

class NetworkController {
    
    var parser: PdbParser!
    
    init() {
        parser = PdbParser()
    }
    
    func loadPDB(of: String, callback:@escaping ((Any) -> Void)) {
        Alamofire.request(self.getPath(with: of)).responseData(completionHandler: { response in
            if let statusCode = response.response?.statusCode {
                print(response.data!)
                print(String(data: response.data!, encoding: .utf8)!)
                print(statusCode)
            }
        })

    }
    
    func getPath(with: String) -> String {
        let firstLetter = String(with.characters.prefix(1))
        return URLS.pdb + firstLetter + "/" + with + "/" + with + URLS.pdbExtension
    }
}
