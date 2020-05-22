//
//  TasksScreenVC.swift
//  VolunteerApp
//
//  Created by Jere Sher on 4/3/20.
//  Copyright © 2020 Pegasus. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import CoreLocation

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var messageLabel: UILabel!
}


class TasksScreenVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let user = Auth.auth().currentUser
    var personalPosts: [PostItem] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(user!.email!)
        
        userRef.addSnapshotListener { (document, error) in
            let documentData = document?.data()
            let name = documentData!["first_name"] as! String
            let location = documentData!["location"] as! String
            self.loadTaskFeed(for: name, at: location)
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personalPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PersonalPostCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TaskTableViewCell
                
        let post = personalPosts[indexPath.row]
        
        cell.messageLabel.text = post.message
        
        return cell
    }
    
    func loadTaskFeed(for name: String, at location: String) {
        let db = Firestore.firestore()
        let usersPostsRef = db.collection("cities").document(location).collection("All Posts").whereField("addedByUser", isEqualTo: name)
        usersPostsRef.order(by: "timestamp", descending: true).getDocuments { (snapshot, error) in
            if error == nil && snapshot != nil && snapshot?.isEmpty == false {
                var updatedUsersPostList: [PostItem] = []
                for document in snapshot!.documents {
                    let documentData = document.data()
                    let postItem = PostItem(snapshot: documentData)
                    updatedUsersPostList.insert(postItem, at: 0)
                }
                self.personalPosts = updatedUsersPostList
                self.tableView.reloadData()
            }
        }
    }
    
}
