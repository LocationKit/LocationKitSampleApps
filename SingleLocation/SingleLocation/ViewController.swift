//
//  ViewController.swift
//  SingleLocation
//
//  Created by Victor Quinn on 11/19/15.
//  Copyright © 2015 LocationKit. All rights reserved.
//

import UIKit

class ViewController: UIViewController, LKLocationManagerDelegate {

    // Instantiate LocationKit and keep an instance around to use in this file
    let locationManager = LKLocationManager()
    
    @IBOutlet weak var currentLocationLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentLocationLabel.text = ""

        // Enable debug mode in non-production builds so we can see what's going on
        #if DEBUG
            self.locationManager.debug = true
        #endif

        // Set your API token (retrieved from https://dashboard.locationkit.io)
        self.locationManager.apiToken = "your_api_token_here"

        // Set this as the advancedDelegate (necessary only for the delegate location request)
        self.locationManager.advancedDelegate = self

        // Start updating location
        // self.locationManager.startUpdatingLocation()
    }

    @IBAction func requestLocationWithHandler(sender: UIButton) {
        // Request the current location with a handler
        self.locationManager.requestLocation { (location: CLLocation?, error: NSError?) -> Void in
            // We have to make sure the location is set, could be nil
            if let location = location {
                // Let's set the label in the center of the screen
                self.currentLocationLabel.text = "(\(location.coordinate.latitude), \(location.coordinate.longitude))"
            } else {
                print("Oops, something went wrong: \(error)")
            }
        }
    }
    
    @IBAction func requestLocationWithDelegate(sender: UIButton) {
        // Request the current location with a delegate
        self.locationManager.requestLocation()
    }

    func locationManager(manager: LKLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            // Let's set the label in the center of the screen
            self.currentLocationLabel.text = "(\(location.coordinate.latitude), \(location.coordinate.longitude))"
        }
    }
}

