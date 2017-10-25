//
//  PdbParser.swift
//  swifty_protein
//
//  Created by Patricio GUZMAN on 10/25/17.
//  Copyright © 2017 Eren OZDEK. All rights reserved.
//

import Foundation

class PdbParser {
    func getMyLigand(name: String, data: String) -> Ligand? {
        var myLigand = Ligand()
        myLigand.name = name
        let array = data.components(separatedBy: "\n")
        for atomData in array {
            let atomDataArray = atomData.components(separatedBy: .whitespacesAndNewlines).filter { !$0.isEmpty }
            if !atomDataArray.isEmpty {
                if atomDataArray[0] == "ATOM" {
                    let atom = self.getAtom(data: atomDataArray)
                    myLigand.atoms.append(atom)
                }
                else if atomDataArray[0] == "CONECT" {
                    let connections = self.getConnection(data: atomDataArray)
                    myLigand.connections.append(contentsOf: connections)
                }
                else {
                    
                }
            }
        }
        return myLigand
    }
    
    func getAtom(data: [String]) -> Atom {
        var atom = Atom()
        atom.x = Float(data[6])
        atom.y = Float(data[7])
        atom.z = Float(data[8])
        atom.element = data[11]
        atom.elementAndNumber = data[2]
        return atom
    }
    
    func getConnection(data: [String]) -> [Connection] {
        var connections: [Connection] = []
        let firstElement = Int(data[1])
        for (index, element) in data.enumerated() {
            if index > 1 {
                var connection = Connection()
                let elementNumber = Int(element)
                connection.atoms = (firstElement!, elementNumber!)
                connections.append(connection)
            }
        }
        return connections
    }
    
    
}
