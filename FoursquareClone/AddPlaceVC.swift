//
//  AddPlaceVC.swift
//  FoursquareClone
//
//  Created by Ali serkan Boyracı  on 3.11.2022.
//

import UIKit

class AddPlaceVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet var placeNameText: UITextField!
    
    @IBOutlet var placeTypeText: UITextField!
    
    @IBOutlet var placeDescribeText: UITextField!
    
    @IBOutlet var placeImageView: UIImageView!
    /*
    placeName, placeType and placeDescribe labels can be send MapVC in 3 ways.
     1. prepare segue, it isnot optimal way.
     2. global variable. it is not preferable for big apps. maybe your personel small apps.
     3. singleton pattern.
        - new swift file
        - create swift class
     */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placeImageView.isUserInteractionEnabled = true // to select Image func activated.
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        placeImageView.addGestureRecognizer(imageTapRecognizer)
        
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        
        if placeNameText.text != "" && placeTypeText.text != "" && placeDescribeText.text != "" {
            if let chosenImage = placeImageView.image {
                
                let placeModel = PlaceModel.sharedInstance
                placeModel.placeName = placeNameText.text!
                placeModel.placeType = placeTypeText.text!
                placeModel.placeDescribe = placeDescribeText.text!
                placeModel.placeImageView = chosenImage
                
            }
            self.performSegue(withIdentifier: "toMapVC", sender: nil)
            
        } else { // if itsnot worked
            let alert  = UIAlertController(title: " Error", message: "Place Name/Type/Describe ???", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
        
        
        
        
        
    }
    //instaapp
    @objc func selectImage() {
        let picker = UIImagePickerController()
        picker.delegate = self // to use picker func.
        picker.sourceType = .photoLibrary // to define data source
        picker.allowsEditing = true // to edit photos
        present(picker, animated: true)
        
    }
    // after selecting photo' to go back VC
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImageView.image = info[.originalImage] as? UIImage // you can select .originalImage or .editedImage
        self.dismiss(animated: true, completion: nil) // to go back normal VC // to close selecting window(picker)
    }
    
 

}
