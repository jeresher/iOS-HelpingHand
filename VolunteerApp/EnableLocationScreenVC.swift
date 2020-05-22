//
//  EnableLocationScreenVC.swift
//  VolunteerApp
//
//  Created by Jere Sher on 3/31/20.
//  Copyright © 2020 Pegasus. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import FirebaseAuth
import Firebase

class EnableLocationScreenVC: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var location: String? = "unknown"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    
    @IBAction func enableButton(_ sender: UIButton) {
        
        if location == "unknown" {
            
            // Open iOS location services popup.
            self.locationManager.requestWhenInUseAuthorization()

        } else if location == "denied" {
            
            // Open settings.
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:]) }
        }
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.denied) {

            // Edit database.
            let user = Auth.auth().currentUser
            let db = Firestore.firestore()
            let docRef = db.collection("users").document(user!.email!)
            docRef.updateData(["location": "denied"])
            location = "denied"
            
        } else if (status == CLAuthorizationStatus.authorizedWhenInUse) {

        }
    }
    
    
    
    // This function triggers once location has been updated.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocation = manager.location else { return }
        fetchCityStateAndCountry(from: location) { city, state, country, error in
            guard let city = city, let state = state, let country = country, error == nil else { return }
            
            // Edit database AND segue.
            let userDatabaseLocation = (city + ", " + state + ", " + country)
            let user = Auth.auth().currentUser
            let db = Firestore.firestore()
            let docRef = db.collection("users").document(user!.email!)
            docRef.updateData(["full location": userDatabaseLocation, "location": "\(city), \(state)"]) { (error) in
                if error == nil {
                    self.transitionToHomeScreenVC()
                }
            }
        }
    }
    
    
    
    func fetchCityStateAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ state: String? , _ country: String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       placemarks?.first?.administrativeArea,
                       placemarks?.first?.country,
                       error)
        }
    }
    
    func transitionToHomeScreenVC() {
        let homeScreenVC = self.storyboard?.instantiateViewController(identifier: "HomeScreenID")
        self.view.window?.rootViewController = homeScreenVC
        self.view.window?.makeKeyAndVisible()
    }
}

