//
//  IndividualRequestVC.swift
//  VolunteerApp
//
//  Created by Jere Sher on 4/1/20.
//  Copyright © 2020 Pegasus. All rights reserved.
//

import UIKit
import Foundation
import FirebaseAuth
import Firebase

class IndividualRequestCell: UITableViewCell {
    @IBOutlet weak var userNameLabel: UILabel!
    
}

class IndividualRequestVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let user = Auth.auth().currentUser
    var posts: [[String]] = [["bird"], ["is"], ["word"]]
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IndividualRequestID", for: indexPath) as! IndividualRequestCell
        let row = indexPath.row
        
        cell.userNameLabel.text = String(posts[row][0])
        
        return cell
    }
    
    
}
