//
//  PlaceModel.swift
//  FoursquareClone
//
//  Created by Ali serkan Boyracı  on 10.11.2022.
//

import Foundation
import UIKit

class PlaceModel {
    
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeDescribe = ""
    var placeImageView = UIImage()
    
    private init () {}
    
}
