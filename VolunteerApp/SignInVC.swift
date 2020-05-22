//
//  SignInVC.swift
//  VolunteerApp
//
//  Created by Jere Sher on 3/29/20.
//  Copyright © 2020 Pegasus. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!    
    var password: String?

    @IBAction func loginButton(_ sender: UIButton) {
        email = emailField.text
        password = passwordField.text
        
        Auth.auth().signIn(withEmail: email!, password: password!) { (result, error) in
            
            if error != nil {
                // Failed to sign in, do this.
                print("code: Error for incorrect login or password.")
            } else {
                // Successfully signed in, do this.
                let homeScreenVC = self.storyboard?.instantiateViewController(identifier: "HomeScreenID")
                // Sets homeScreenVC as root view controller.
                self.view.window?.rootViewController = homeScreenVC
                // Presents homeScreenVC.
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
}
