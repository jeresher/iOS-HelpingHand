//
//  HomeScreenVC.swift
//  VolunteerApp
//
//  Created by Jere Sher on 3/29/20.
//  Copyright © 2020 Pegasus. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import CoreLocation


class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UITextView!
}

class HomeScreenVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let user = Auth.auth().currentUser
    var posts: [PostItem] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(user!.email!)
        var userlocation: String?
        
        // Segue to "EnableLocationScreenVC" if user location does not exist, otherwise load data.
        userRef.getDocument { (document, error) in
            userlocation = document?.get("location") as? String
            if userlocation == "unknown" || userlocation == "denied" {
                self.performSegue(withIdentifier: "HomeScreenToEnableLocationScreen", sender: userlocation)
            } else {
                self.loadHomeFeed(with: userlocation!)
            }
        }

        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PostCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! HomeTableViewCell
                
        let post = posts[indexPath.row]
        
        cell.nameLabel.text = post.addedByUser
        
        cell.messageLabel.text = post.message
        
        return cell
    }
    
    func loadHomeFeed(with userlocation: String) {
        let db = Firestore.firestore()
        let allPostsRef = db.collection("cities").document(userlocation).collection("All Posts")
        allPostsRef.order(by: "timestamp", descending: false).getDocuments { (snapshot, error) in
            if error == nil && snapshot != nil && snapshot?.isEmpty == false {
                var updatedPostList: [PostItem] = []
                for document in snapshot!.documents {
                    let documentData = document.data()
                    let postItem = PostItem(snapshot: documentData)
                    updatedPostList.insert(postItem, at: 0)
                }
                self.posts = updatedPostList
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeScreenToEnableLocationScreen" {
            if let vc = segue.destination as? EnableLocationScreenVC {
                vc.location = sender as? String
            }
        }
    }
    

}


