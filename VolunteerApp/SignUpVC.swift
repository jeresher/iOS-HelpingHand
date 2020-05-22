//
//  NameSignUpVC.swift
//  VolunteerApp
//
//  Created by Jere Sher on 3/28/20.
//  Copyright © 2020 Pegasus. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

var firstName: String?
var lastName: String?
var email: String?

class NameSignUpVC: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        DesignUtilities.styleTextField(firstNameField)
        DesignUtilities.styleTextField(lastNameField)
        
        continueButton.isEnabled = false
        continueButton.isUserInteractionEnabled = false
        
        monitorIfTextBoxesAreEdited()
    }
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    
    @IBAction func continueButton(_ sender: UIButton) {
        firstName = firstNameField.text
        lastName = lastNameField.text
        self.performSegue(withIdentifier: "NameSignUpToEmailSignUp", sender: nil)
    }
    
    func monitorIfTextBoxesAreEdited() {
        firstNameField.addTarget(self, action: #selector(executeThisIfTextBoxIsEdited), for: .editingChanged)
        lastNameField.addTarget(self, action: #selector(executeThisIfTextBoxIsEdited), for: .editingChanged)
    }
    
    @objc func executeThisIfTextBoxIsEdited(sender: UITextField) {
        sender.text = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard
            let firstName = firstNameField.text, !firstName.isEmpty,
            let lastName = lastNameField.text, !lastName.isEmpty
            else {
                self.continueButton.isEnabled = false
                self.continueButton.isUserInteractionEnabled = false
                return
        }
        // enable button if all conditions are met
        continueButton.isEnabled = true
        continueButton.isUserInteractionEnabled = true
    }
    
}







class EmailSignUpVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        DesignUtilities.styleTextField(emailField)
        
        continueButton.isEnabled = false
        continueButton.isUserInteractionEnabled = false
        
        print(firstName!)
        
        monitorIfTextBoxesAreEdited()
    }
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    
    @IBAction func continueButton(_ sender: UIButton) {
        email = emailField.text
        // Check if email is valid
        if FormUtilities.isValidEmail(email!) {
            continueIfEmailIsAvailable(email!)
        } else {
            print("code: error for invalid email structure.")
        }
    }
    
    func monitorIfTextBoxesAreEdited() {
        emailField.addTarget(self, action: #selector(executeThisIfTextBoxIsEdited), for: .editingChanged)
    }
    
    @objc func executeThisIfTextBoxIsEdited(sender: UITextField) {
        sender.text = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard
            let email = emailField.text, !email.isEmpty
            else {
                self.continueButton.isEnabled = false
                self.continueButton.isUserInteractionEnabled = false
                return
        }
        // enable button if all conditions are met
        continueButton.isEnabled = true
        continueButton.isUserInteractionEnabled = true
    }
    
    func continueIfEmailIsAvailable(_ email: String) {
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(email)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                // Do this if email is taken.
                print("code: error for when email is taken.")
            } else {
                // Do this if email is available.
                self.performSegue(withIdentifier: "EmailSignUpToPasswordSignUp", sender: nil)
            }
        }
    }
    
    
}








class PasswordSignUpVC: UIViewController {
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    var password: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        DesignUtilities.styleTextField(passwordField)
        
        signUpButton.isEnabled = false
        signUpButton.isUserInteractionEnabled = false
        
        monitorIfTextBoxesAreEdited()
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        password = passwordField.text
        // Create the user
        Auth.auth().createUser(withEmail: email!, password: password!) { (result, error) in
            
            if error != nil {
                // If there was an error creating the user
                print(error!.localizedDescription)
            } else {
                // If the user was created successfully
                let db = Firestore.firestore()
                
                db.collection("users").document(email!).setData([
                    "first_name": firstName!,
                    "last_name": lastName!,
                    "email": email!,
                    "uid": result!.user.uid,
                    "location": "unknown"
                ])
            
                self.transitionToHomeScreenVC()
            }
        }
    }
    
    func monitorIfTextBoxesAreEdited() {
        passwordField.addTarget(self, action: #selector(executeThisIfTextBoxIsEdited), for: .editingChanged)
    }
    
    @objc func executeThisIfTextBoxIsEdited(sender: UITextField) {
        sender.text = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard
            let password = passwordField.text, !password.isEmpty, password.count >= 8
            else {
                self.signUpButton.isEnabled = false
                return
        }
        // enable button if all conditions are met
        signUpButton.isEnabled = true
        signUpButton.isUserInteractionEnabled = true
    }
    
    func transitionToHomeScreenVC() {
        let homeScreenVC = storyboard?.instantiateViewController(identifier: "HomeScreenID")
        // Sets homeScreenVC as root view controller.
        view.window?.rootViewController = homeScreenVC
        // Presents homeScreenVC.
        view.window?.makeKeyAndVisible()
        
    }
}
