//
//  DetailsVC.swift
//  FoursquareClone
//
//  Created by Ali serkan Boyracı  on 5.11.2022.
//

import UIKit
import MapKit
import Parse


class DetailsVC: UIViewController {
    
    @IBOutlet var detailsImageView: UIImageView!
    
    @IBOutlet var detailsNameLabel: UILabel!
    
    @IBOutlet var detailsTypeLabel: UILabel!
    
    @IBOutlet var detailsDescriptionLabel: UILabel!
    
    @IBOutlet var detailsMapView: MKMapView!
    
    var chosenPlaceId = "" // to equaled ID to other side
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: chosenPlaceId)
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                
            } else {
                print(objects)
            }
        }


    }
    


}
