//
//  FormUtilities.swift
//  VolunteerApp
//
//  Created by Jere Sher on 3/29/20.
//  Copyright © 2020 Pegasus. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class FormUtilities {
        
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
        
    }
    
    static func isUnusedEmail(_ email: String) -> Bool {
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(email)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                // 
            } else {
                //
            }
        }
        
        return false
    }
}
