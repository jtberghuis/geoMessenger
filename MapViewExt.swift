//
//  MapViewExt.swift
//  geoMessenger
//
//  Created by Jordan Berghuis on 8/13/18.
//  Copyright © 2018 Jordan Berghuis. All rights reserved.
//

import UIKit
import MapKit

extension FirstViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        if let annotation = annotation as? Messege{
            let identifier = "Pin"
            var view: MKPinAnnotationView
            if let dequeuedView = MapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView{
                dequeuedView.annotation = annotation
                view = dequeuedView
            }
            else{
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canshowCallout = true
                view.calloutOffset = CGPoint (x:-8, y:-5)
                view.pinTintColor = .green
                view.animatesDrop = true
                view.rightCalloutAccessoryView = UIButton (type: .detailDisclosure) as UIButton
            }
            return view
        }
        return nil
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl){
        let messege = view.annotation as! Messege
        let placeName = messege.title
        let placeInfo = messege.subtitle
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        ac.addAction(UIAlertAction(title: "Remove", style: .default){
            (result: UIAlertAction)->Void in
            mapView.removeAnnotation(messege)
        })
        present(ac, animated: true)
    }
}
