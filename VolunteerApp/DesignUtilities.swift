//
//  DesignUtilities.swift
//  VolunteerApp
//
//  Created by Jere Sher on 3/29/20.
//  Copyright © 2020 Pegasus. All rights reserved.
//

import Foundation
import UIKit

class DesignUtilities {
    
    static func styleTextField(_ textfield: UITextField) {
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height:2)
        bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1).cgColor
        
        textfield.borderStyle = .none
        
        textfield.layer.addSublayer(bottomLine)
    }
    
    static func styleFilledButton(_ button: UIButton) {
        // Filled rounded corner style
        button.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ button: UIButton) {
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
}
