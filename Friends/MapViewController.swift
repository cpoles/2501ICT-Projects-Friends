//
//  MapViewController.swift
//  Friends
//
//  Created by Carlos Poles on 29/05/2016.
//  Copyright © 2016 Carlos Poles. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var txtAddress: UITextField!
    
    let locationManager = CLLocationManager()
    
    var locationString: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        txtAddress.delegate = self
        txtAddress.text = locationString
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
       searchLocation()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtAddress.resignFirstResponder()
        searchLocation()
        return true
    }
    
    // MARK: - Methods

    func searchLocation() {
        let brisbane = CLLocationCoordinate2D(latitude: -27, longitude: 153)
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(locationString!, in: CLCircularRegion(center: brisbane, radius: 100000, identifier: "Brisbane")) { (placemarks:[CLPlacemark]?, error: NSError?) in
            if let e = error {
                print(e.localizedDescription)
            }
            guard let placemark = placemarks?.first, let location = placemark.location else {
                print("Could not identify location '\(self.locationString)'")
                return
            }
            print("Found \(location) as the first for \(self.locationString)")
            let locationRegion = MKCoordinateRegion(center: brisbane, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
            self.mapView.setRegion(locationRegion, animated: true)
        } as! CLGeocodeCompletionHandler as! CLGeocodeCompletionHandler 
        
    }

    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        let allowed: Bool
        switch status {
        // User has not yet made a choice with regards to this application
        case .notDetermined:
            allowed = false
            print("Not determined yet")
            // This application is not authorized to use location services.  Due
            // to active restrictions on location services, the user cannot change
        // this status, and may not have personally denied authorization
        case .restricted:
            allowed = false
            print("user denied using locator")
            // User has explicitly denied authorization for this application, or
        // location services are disabled in Settings.
        case .denied:
            allowed = false
            print("User denied using location")
            
            // User has granted authorization to use their location at any time,
        // including monitoring for regions, visits, or significant location changes.
        case .authorizedAlways:
            allowed = true
            print("Even works in background")
            
            // User has granted authorization to use their location only when your app
            // is visible to them (it will be made visible to them if you continue to
            // receive location updates while in the background).  Authorization to use
            // launch APIs has not been granted.
            
        case .authorizedWhenInUse:
            allowed = true
            print("User authorized using location when in use")
            
        }
        
        if allowed {
            locationManager.startUpdatingLocation()
        }
    }
    
    }
