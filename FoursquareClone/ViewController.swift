//
//  ViewController.swift
//  FoursquareClone
//
//  Created by Ali serkan Boyracı  on 30.10.2022.
//

import UIKit
import Parse



class ViewController: UIViewController {

    
    @IBOutlet var usernameText: UITextField!
    
    @IBOutlet var passwordText: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        let parseObject = PFObject(className: "Fruits") //  to create fruit class
        parseObject["name"] = "Banana" // make a dict
        parseObject["calorie"] = 150
        parseObject.saveInBackground { (success, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                print("uploaded")
            }
        }*/
        
        /*
        // to take data
        let query = PFQuery(className: "Fruits") // to make call from created class
        query.whereKey("name", equalTo: "Apple") // to addinfg filter to data.

        query.findObjectsInBackground { (objects, error) in //gives us PFObject beacuse, we work it and it is array: maybe more than one or nothing.
            if error != nil {
                print(error?.localizedDescription)
            } else {
                print(objects)
            }
        }*/
          
        
        
        
        
    }

    @IBAction func signInClicked(_ sender: Any) {
        
        if usernameText.text != "" && passwordText.text != "" {
            
            PFUser.logInWithUsername(inBackground: usernameText.text!, password: passwordText.text!) { (user, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    //segue
                    print("welcome")
                    print(user?.username)
                }
            }
            
            
        } else {
            makeAlert(titleInput: "Error", messageInput: "Username/Password ???")
        }
        
        
        
    }
    
    
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if usernameText.text != "" && passwordText.text != "" {
            
            let user = PFUser()
            user.username = usernameText.text!
            user.password = passwordText.text!
            
            user.signUpInBackground { (success, error) in
                if error != nil {
                    self.makeAlert(titleInput: "error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    //segue
                    print("OK")
                    
                }
            }
            
            
            
        } else {
            makeAlert(titleInput: "Errror", messageInput: "Username/Password ???")
            
        }
        
        
        
    }
    
    func makeAlert(titleInput:String, messageInput:String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}

