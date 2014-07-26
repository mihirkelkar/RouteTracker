//
//  ViewController.swift
//  RouteTracker
//
//  Created by Mihir Kelkar on 7/26/14.
//  Copyright (c) 2014 Mihir Kelkar. All rights reserved.
//

import UIKit
import MapKit
import corelocation

class ViewController: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate{
    
    @IBOutlet var Route: UIBarButtonItem
    @IBOutlet var mapView: MKMapView
    var locationmanager:CLLocationManager!
    var myAddress:CLGeocoder!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view, typically from a nib.
        locationmanager = CLLocationManager()
        locationmanager.requestAlwaysAuthorization()
        locationmanager.delegate = self
        locationmanager.locationServicesEnabled
        locationmanager.desiredAccuracy = kCLLocationAccuracyBest
        locationmanager.startUpdatingLocation()
        println("\(locationmanager.location)")
        mapView.setCenterCoordinate(locationmanager.location.coordinate, animated: true)
        mapView.showAnnotations(mapView.annotations, animated: true)
        myAddress = CLGeocoder()
        myAddress.reverseGeocodeLocation(locationmanager.location, completionHandler:{(placemarks, error)->Void in
            
            if error {
                println("Reverse geocoder failed with error" + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0 {
                let pm = placemarks[0] as CLPlacemark
                self.displayLocationInfo(pm)
            } else {
                println("Problem with the data received from geocoder")
            }
            })
    }

    func displayLocationInfo(placemark: CLPlacemark) {
        if placemark != nil {
            //stop updating location to save battery life
            locationmanager.stopUpdatingLocation()
            println(placemark.locality ? placemark.locality : "")
            println(placemark.postalCode ? placemark.postalCode : "")
            println(placemark.administrativeArea ? placemark.administrativeArea : "")
            println(placemark.country ? placemark.country : "")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

