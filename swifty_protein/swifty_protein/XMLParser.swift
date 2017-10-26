//
//  File.swift
//  swifty_protein
//
//  Created by Eren OZDEK on 10/26/17.
//  Copyright © 2017 Eren OZDEK. All rights reserved.
//

import Foundation

class Item {
    var author = "";
    var desc = "";
    var tag = [Tag]();
}

class Tag {
    var name = "";
    var count: Int?;
}



class XMLParser {
    let xml = SWXMLHash.config {
        config in
        config.shouldProcessLazily = true
        }.parse(xmlToParse)
    let xml = SWXMLHash.lazy(xmlToParse)
    
    func parser() -> Infos {
        
    }
    
//    let xmlData = XMLString.dataUsingEncoding(NSUTF8StringEncoding)!
//    let parser = XMLParser(data: xmlData)
//    
//    parser.delegate = self;
//    
//    parser.parse()
//    
//    var items = [Item]();
//    var item = Item();
//    var foundCharacters = "";
//    
//    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
//        if elementName == "tag" {
//            let tempTag = Tag();
//            if let name = attributeDict["name"] {
//                tempTag.name = name;
//            }
//            if let c = attributeDict["count"] {
//                if let count = Int(c) {
//                    tempTag.count = count;
//                }
//            }
//            self.item.tag.append(tempTag);
//        }
//    }
//    
//    
//    func getInfo(name: String, data: String) -> Infos {
//        var name: String!
//        var nbAtoms: Int!
//        
//        name = "hello"
//        nbAtoms = 33
//                                                                                                                                                                                                                  
//        return Infos.init(name: name, nbAtoms: nbAtoms)
//    }
}
