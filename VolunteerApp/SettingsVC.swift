//
//  SettingsVC.swift
//  VolunteerApp
//
//  Created by Jere Sher on 4/3/20.
//  Copyright © 2020 Pegasus. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import CoreLocation

class SettingsVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signOutButton(_ sender: UIButton) {
        try! Auth.auth().signOut()
        
        let startingScreenVC = self.storyboard?.instantiateViewController(identifier: "StartingScreenID")
        self.view.window?.rootViewController = startingScreenVC
        self.view.window?.makeKeyAndVisible()
    }
}
