//
//  ViewController.swift
//  CurrentPlace
//
//  Created by Victor Quinn on 11/20/15.
//  Copyright (c) 2015 SocialRadar. All rights reserved.
//


import UIKit


class ViewController: UIViewController {

    let locationManager = LKLocationManager()

    @IBOutlet weak var placeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.placeLabel.text = "Place undetermined"

        #if DEBUG
        locationManager.debug = true
        #endif
        locationManager.apiToken = "your_api_token_here"
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func whereAmI(sender: UIButton) {
        locationManager.requestPlace { (place: LKPlacemark?, error: NSError?) -> Void in
            if let place = place {
                self.placeLabel.text = "\(place.subThoroughfare!) \(place.thoroughfare!), \(place.locality!), \(place.administrativeArea!)"
            } else if error != nil {
                print("Uh oh, got an error: \(error)")
            } else {
                self.placeLabel.text = "Place could not be determined"
            }
        }
    }
}
