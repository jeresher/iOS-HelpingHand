//
//  StartingScreenVC.swift
//  VolunteerApp
//
//  Created by Jere Sher on 3/28/20.
//  Copyright © 2020 Pegasus. All rights reserved.
//

import UIKit
import FirebaseAuth

class StartingScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // If user information is saved, transition to HomeScreen.
        if Auth.auth().currentUser != nil {
            print("Data is saved!")
            print(Auth.auth().currentUser!.uid)
            self.transitionToHomeScreenVC()
        }
    }
        
    
    @IBAction func signInButton(_ sender: Any) {
        self.performSegue(withIdentifier: "StartingScreenToSignIn", sender: nil)
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
         self.performSegue(withIdentifier: "StartingScreenToNameSignUp", sender: nil)
    }
    
    func transitionToHomeScreenVC() {
        let homeScreenVC = storyboard?.instantiateViewController(identifier: "HomeScreenID")
        // Sets homeScreenVC as root view controller.
        view.window?.rootViewController = homeScreenVC
        // Presents homeScreenVC.
        view.window?.makeKeyAndVisible()
    }
}
