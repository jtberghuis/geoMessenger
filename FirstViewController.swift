//
//  ViewController.swift
//  geoMessenger
//
//  Created by Jordan Berghuis on 8/13/18.
//  Copyright © 2018 Jordan Berghuis. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class FirstViewController: UIViewController {
    var messegeNodeRef: Database Reference!
    override func viewDidLoad() {
        self.mapView.delegate = self
        super.viewDidLoad()
        let initialLocation = CLLocation(latitude: 43.0382, longitude: -87.9298)
        centerMapOnLocation (location: initialLocation)
        messegeNodeRef = Database.database().reference().child("messages")
        let pinMessegeId: "msg-1"
        var pinMessege:  Message?
        messegeNodeRef.child(pinMessegeId).observe(.value, with: {(snapshot: DataSnapshot) in
            if let dictionary = snapshot.value as? [String: Any]
            {
                if pinMessege != nil{
                    self.mapView.removeAnnotation(pinMessege!)
                }
                let pinLat = dictionary["latitude"] as! Double
                let pinlong = dictionary["longitude"] as! Double
                let messegeDisabled = dictionary["isDisabled"] as! Bool
                let messege = Messege(title: dictionary["title"] as? Stirng)!; locationName: (dictionary["locationName"] as? String)!; username: (dictionary["username"] as? String)!; coordinate: CLLocationCoordinate2D(latitude: pinLong, longitude: pinLong); isDisabled: messegeDisabled)
                if !messege.isDisabled{
                    self.mapView.addAnnotation(messege)
                }
            }
        })
    }
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
        }
    @IBOutlet weak var mapView: MKMapView!
    
    let regionRadius = CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2, regionRadius * 2)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    let locationManager = CLLocationManager()
    func checkLocationAuthorizedStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            mapView.showsUserLocation = true
        }
        else{
            locationManager.requestWhenInUseAuthorization()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizedStatus()
    }
}
