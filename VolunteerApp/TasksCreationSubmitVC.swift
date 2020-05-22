//
//  TasksCreationSubmitVC.swift
//  VolunteerApp
//
//  Created by Jere Sher on 4/3/20.
//  Copyright © 2020 Pegasus. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import CoreLocation

class TasksCreationSubmitVC: UIViewController {
    
    let db = Firestore.firestore()
    let user = Auth.auth().currentUser
    
    var category: String?
    var location: String?
    var name: String?
    @IBOutlet weak var subject: UITextField!
    @IBOutlet weak var message: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userRef = db.collection("users").document(user!.email!)
        userRef.getDocument { (document, error) in
            let documentData = document?.data()
            self.location = documentData!["location"] as? String
            self.name = documentData!["first_name"] as? String
            
        }
    }
    
    
    
    @IBAction func submitButton(_ sender: UIButton) {
        if location != nil && category != nil {
            let postRef = db.collection("cities").document(location!).collection("All Posts").document()
            let post = PostItem(addedByUser: name!, userEmail: (user?.email!)!, subject: subject.text!, message: message.text!, category: category!, location: location!, timestamp: FieldValue.serverTimestamp(), documentID: postRef.documentID)
            postRef.setData(post.toAnyObject())
            
            
            let userTaskRef = db.collection("users").document((user?.email!)!).collection("All Posts").document()
            userTaskRef.setData([
                "documentID": postRef.documentID
            ])
            
        }
    }
    
    

}
