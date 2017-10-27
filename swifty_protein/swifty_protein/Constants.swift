//
//  Constants.swift
//  swifty_protein
//
//  Created by Patricio GUZMAN on 10/27/17.
//  Copyright © 2017 Eren OZDEK. All rights reserved.
//

import UIKit

struct Contants {
    static let cameraPositionZ: Float = 30
    static let textScale: Float = 0.04
    static let atomRadius = CGFloat(0.4)
    static let conectorRadius = CGFloat(0.05)
    struct textPosition {
        static let x: Float = -(Float)(Contants.atomRadius)
        static let y: Float = -(Float)(Contants.atomRadius)
        static let z: Float =  (Float)(Contants.atomRadius)
    }
    static let personalizedMessage = "Hey!, take a look at this Ligand number "
}

struct URLS {
    static let pdb = "http://ligand-expo.rcsb.org/reports/"
    static let pdbIdeal = "_ideal.pdb"
    static let pdbModel = "_model.pdb"
}
