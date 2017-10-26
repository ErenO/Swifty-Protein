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
    static let pdbIdeal = "_ideal.pdb"
    static let pdbModel = "_model.pdb"
}

class NetworkController {
    var defaultExtension = URLS.pdbIdeal
    var parser: PdbParser!
    
    init() {
        parser = PdbParser()
    }
    
    func loadPDB(of: String, callback:@escaping ((Any?) -> Void)) {
        Alamofire.request(self.getPath(with: of)).responseData(completionHandler: { response in
            if response.response?.statusCode == 200 {
                let fileData = String(data: response.data!, encoding: .utf8)
                print(fileData?.characters.count)
                if fileData?.characters.count == 0 {
                    if self.defaultExtension == URLS.pdbModel {
                        callback(nil)                                                        // maybe this will never be reach but i case neither of the url returns something
                        return
                    }
                    else {
                        self.defaultExtension = URLS.pdbModel
                        self.loadPDB(of: of, callback: callback)
                        self.defaultExtension = URLS.pdbIdeal
                    }
                }
                else {
                    let myLigand = self.parser.getMyLigand(name: of, data: fileData!)
                    callback(myLigand)
                }
            }
            else {
                callback(nil)
            }
        })
        
    }
    
    func getPath(with: String) -> String {
        let firstLetter = String(with.characters.prefix(1))
        return URLS.pdb + firstLetter + "/" + with + "/" + with + self.defaultExtension
    }
}
