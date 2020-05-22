//
//  PostItem.swift
//  VolunteerApp
//
//  Created by Jere Sher on 4/3/20.
//  Copyright © 2020 Pegasus. All rights reserved.
//

import Foundation
import Firebase

struct PostItem {
    
    let addedByUser: String!
    let userEmail: String!
    let subject: String!
    let message: String!
    let category: String!
    let location: String!
    var timestamp: Any!
    var documentID: Any!
    
    init(addedByUser: String, userEmail: String, subject: String, message: String!, category: String!, location: String!, timestamp: Any!, documentID: Any!) {
        self.addedByUser = addedByUser
        self.userEmail = userEmail
        self.subject = subject
        self.message = message
        self.category = category
        self.location = location
        self.timestamp = timestamp
        self.documentID = documentID
    }
    
    
    init(snapshot: [String : Any]) {
        addedByUser = snapshot["addedByUser"] as? String
        userEmail = snapshot["userEmail"] as? String
        subject = snapshot["subject"] as? String
        message = snapshot["message"] as? String
        category = snapshot["category"] as? String
        location = snapshot["location"] as? String
        timestamp = snapshot["timestamp"] as Any
        documentID = snapshot["documentID"] as Any
    }
    
    func toAnyObject() -> [String : Any] {
        return [
            "addedByUser": addedByUser!,
            "userEmail": userEmail!,
            "subject": subject!,
            "message": message!,
            "category": category!,
            "location": location!,
            "timestamp": timestamp!,
            "documentID": documentID!
        ]
    }
}
