//
//  MapVC.swift
//  FoursquareClone
//
//  Created by Ali serkan Boyracı  on 5.11.2022.
//

import UIKit
import MapKit

class MapVC: UIViewController {

    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonClicked))
        // we couldnt see save button. fot this, we add navigationcontroller to mapvc
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(backButtonclicked))
        
        print(PlaceModel.sharedInstance.placeName)


    }
    
    @objc func saveButtonClicked() {
        //parse
        
    }
    @objc func backButtonclicked() {
        //navigationController?.popViewController(animated: true) //there isnt any VC before mapVC, because of this itsnt worked.
        
        self.dismiss(animated: true)
        
    }
    


}
