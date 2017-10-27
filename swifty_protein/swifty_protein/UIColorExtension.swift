//
//  UIColorExtension.swift
//  swifty_protein
//
//  Created by Patricio GUZMAN on 10/27/17.
//  Copyright © 2017 Eren OZDEK. All rights reserved.
//
import UIKit

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
    static let CPKColors: [String : UIColor] = ["H" : UIColor.init(hex: "ffffff"),
                                                "C" : UIColor.init(hex: "000000"),
                                                "N" : UIColor.init(hex: "00008b"),
                                                "O" : UIColor.init(hex: "ff0000"),
                                                "F" : UIColor.init(hex: "008000"),
                                                "Cl" : UIColor.init(hex: "008000"),
                                                "Br" : UIColor.init(hex: "8b0000"),
                                                "I" : UIColor.init(hex: "9400d3"),
                                                "He" : UIColor.init(hex: "00ffff"),
                                                "Ne" : UIColor.init(hex: "00ffff"),
                                                "Ar" : UIColor.init(hex: "00ffff"),
                                                "Xe" : UIColor.init(hex: "00ffff"),
                                                "Kr" : UIColor.init(hex: "00ffff"),
                                                "P" : UIColor.init(hex: "ffa500"),
                                                "S" : UIColor.init(hex: "ffff00"),
                                                "B" : UIColor.init(hex: "fa8072"),
                                                "Li" : UIColor.init(hex: "ee82ee"),
                                                "Na" : UIColor.init(hex: "ee82ee"),
                                                "K" : UIColor.init(hex: "ee82ee"),
                                                "Rb" : UIColor.init(hex: "ee82ee"),
                                                "Cs" : UIColor.init(hex: "ee82ee"),
                                                "Fr" : UIColor.init(hex: "ee82ee"),
                                                "Be" : UIColor.init(hex: "006400"),
                                                "Mg" : UIColor.init(hex: "006400"),
                                                "Ca" : UIColor.init(hex: "006400"),
                                                "Sr" : UIColor.init(hex: "006400"),
                                                "Ba" : UIColor.init(hex: "006400"),
                                                "Ra" : UIColor.init(hex: "006400"),
                                                "Ti" : UIColor.init(hex: "808080"),
                                                "Fe" : UIColor.init(hex: "ff8c00")]
}
