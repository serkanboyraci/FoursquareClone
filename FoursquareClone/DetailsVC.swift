//
//  DetailsVC.swift
//  FoursquareClone
//
//  Created by Ali serkan Boyracı  on 5.11.2022.
//

import UIKit
import MapKit
import Parse


class DetailsVC: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var detailsImageView: UIImageView!
    
    @IBOutlet var detailsNameLabel: UILabel!
    
    @IBOutlet var detailsTypeLabel: UILabel!
    
    @IBOutlet var detailsDescriptionLabel: UILabel!
    
    @IBOutlet var detailsMapView: MKMapView!
    
    var chosenPlaceId = "" // to equaled ID to other side
    
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataFromParse()
        detailsMapView.delegate = self // bcause of MKMapViewDelegate
        
        

    }
    
    func getDataFromParse() {
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: chosenPlaceId)
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                
            } else {
                if objects != nil {
                    let chosenPlaceObject = objects![0]
                    
                    // OBJECTS
                    if let placeName = chosenPlaceObject.object(forKey: "name") as? String {
                        self.detailsNameLabel.text = placeName
                    }
                    if let placeType = chosenPlaceObject.object(forKey: "type") as? String {
                        self.detailsTypeLabel.text = placeType
                    }
                    if let placeDescription = chosenPlaceObject.object(forKey: "describe") as? String {
                        self.detailsDescriptionLabel.text = placeDescription
                    }
                    if let placeLatitude = chosenPlaceObject.object(forKey: "latitude") as? String { //to take coordinates
                        if let placeLatitudeDouble = Double(placeLatitude) {
                            self.chosenLatitude = placeLatitudeDouble
                        }
                    }
                    if let placeLongitude = chosenPlaceObject.object(forKey: "longitude") as? String {
                        if let placeLongitudeDouble = Double(placeLongitude) {
                            self.chosenLongitude = placeLongitudeDouble
                        }
                    }
                    // to take image: first take image data and  change it to UIImageView
                    if let imageData = chosenPlaceObject.object(forKey: "image") as? PFFileObject {
                        imageData.getDataInBackground { (data, error) in
                            if error == nil {
                                if data != nil { // to prevent any error
                                    self.detailsImageView.image = UIImage(data: data!)
                                }
                            }
                        }
                    }
                    //MAPS
                    
                    let location = CLLocationCoordinate2D(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
                    
                    let span = MKCoordinateSpan(latitudeDelta: 0.0010, longitudeDelta: 0.0010)
                    
                    let region = MKCoordinateRegion(center: location, span: span)
                    
                    self.detailsMapView.setRegion(region, animated: true)
                    
                    // to show exact position with annotation
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = location
                    annotation.title = self.detailsNameLabel.text!
                    annotation.subtitle = self.detailsTypeLabel.text!
                    self.detailsMapView.addAnnotation(annotation)
                }
            }
        }
    }
    // annotations to add navigation-- first add MKMapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? { //to add i button
        if annotation is MKUserLocation { // if there is user annotation, we dont want to use it.
            return nil
        }
        
        let reuseId = "pin" // to use it easily reuseId
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        
        if pinView == nil {
            pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true // after tapping adding and showing some image or sth
            let button = UIButton(type: .detailDisclosure) // adding i image
            pinView?.rightCalloutAccessoryView = button
        } else {
            pinView?.annotation = annotation // if there is any annotation define as it
        }
        return pinView // to use pinView
    }
    
    // after tapping button write calloutAccesory...
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if self.chosenLongitude != 0.0 && self.chosenLatitude != 0.0 { // to control latitude and longitude
            let requestLocation = CLLocation(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
                
            CLGeocoder().reverseGeocodeLocation(requestLocation) { (placemarks, error) in
                if let placemark = placemarks {
                    
                    if placemark.count > 0 { //contro there is somewhere
                        let mkPlaceMark = MKPlacemark(placemark: placemark[0])
                        let mapItem = MKMapItem(placemark: mkPlaceMark) // to open navigation and placemark is used for this
                        mapItem.name = self.detailsNameLabel.text
                        
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving] // beacuse of needed launchoptions we define this type as a driving as default.
                         
                        mapItem.openInMaps(launchOptions: launchOptions) // we need launch options here.
                    }
                }
                
            }
        }
    }


}
