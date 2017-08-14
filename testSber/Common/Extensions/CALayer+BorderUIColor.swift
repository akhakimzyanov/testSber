//
//  CALayer+BorderUIColor.swift
//  testSber
//
//  Created by Aidar on 14.08.17.
//  Copyright © 2017 Aidar Khakimzyanov. All rights reserved.
//

import UIKit

extension CALayer {
    
    var borderUiColor: UIColor {
        get {
            return UIColor(cgColor: borderColor!)
        } set {
            borderColor = newValue.cgColor
        }
    }
}
