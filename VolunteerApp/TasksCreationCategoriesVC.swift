//
//  TasksCreationCategoriesVC.swift
//  VolunteerApp
//
//  Created by Jere Sher on 4/3/20.
//  Copyright © 2020 Pegasus. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import CoreLocation

class TasksCreationCategoriesVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func requestHelpButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "TasksCreationCategoriesToTasksCreationSubmit", sender: "requestHelp")
    }
    
    @IBAction func offerHelpButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "TasksCreationCategoriesToTasksCreationSubmit", sender: "offerHelp")
    }
    
    @IBAction func generalButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "TasksCreationCategoriesToTasksCreationSubmit", sender: "general")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TasksCreationCategoriesToTasksCreationSubmit" {
            if let vc = segue.destination as? TasksCreationSubmitVC {
                vc.category = sender as? String
            }
        }
    }
    

}
