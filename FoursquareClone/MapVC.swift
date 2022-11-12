//
//  MapVC.swift
//  FoursquareClone
//
//  Created by Ali serkan Boyracı  on 5.11.2022.
//

import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    // to save parse as String
    var chosenLatitude = ""
    var chosenLongitude = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonClicked))
        // we couldnt see save button. fot this, we add navigationcontroller to mapvc
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(backButtonclicked))
        
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // to take best reply
        locationManager.requestWhenInUseAuthorization() // just using app
        locationManager.startUpdatingLocation() // to update users location
        
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        recognizer.minimumPressDuration = 3 // to set seconds tapped
        mapView.addGestureRecognizer(recognizer)
                                                      
        
        
    }
    
    @objc func chooseLocation(gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizer.State.began {
            
            let touches = gestureRecognizer.location(in: self.mapView)
            let coordinates = self.mapView.convert(touches, toCoordinateFrom: self.mapView) // change touches to coordinate by self.mapView
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = PlaceModel.sharedInstance.placeName
            annotation.subtitle = PlaceModel.sharedInstance.placeType
            
            self.mapView.addAnnotation(annotation)
            
            self.chosenLatitude = String(coordinates.latitude)
            self.chosenLongitude = String(coordinates.longitude)
        }
            
    }
    
    // when updating users location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        locationManager.stopUpdatingLocation() // to stop update location everytime. to use last stop location.
        
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) // zoom scale number
        let region = MKCoordinateRegion(center: location, span: span) // to set area
        mapView.setRegion(region, animated: true)
    }
    
    @objc func saveButtonClicked() {
        //parse
        
    }
    @objc func backButtonclicked() {
        //navigationController?.popViewController(animated: true) //there isnt any VC before mapVC, because of this itsnt worked.
        
        self.dismiss(animated: true)
        
    }
    


}
