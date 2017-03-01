//
//  VerifyViewController.swift
//  PayForwardTest
//
//  Created by Sarthak Khillon on 2/28/17.
//  Copyright © 2017 Sarthak Khillon. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class VerifyViewController: UIViewController, UITextFieldDelegate {
    
    var ref = FIRDatabase.database().reference()
    
    // User Information
    var userFirstName: String!
    var userLastName: String!
    var userBirthday: String!
    var userZipCode: String!
    var userEmail: String!
    var userPassword: String!
    var userPhoneNumber: String!
    
    // MARK: Connectors
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var policyLabel: UILabel!
    
    @IBAction func verifyButtonTapped(_ sender: Any) {
        if phoneNumberIsValid() {
            self.userPhoneNumber = self.phoneNumberTextField.text!
            
            FIRAuth.auth()?.createUser(withEmail: self.userEmail, password: self.userPassword) { (user, error) in
                
                if error == nil {
                    // persist data to user profile.
                    // this method intentionally overwrites all child nodes under this user in the
                    // unlikely possibility that there is already data stored in those fields.
                    let userPath = self.ref.child("users")
                    userPath.setValue(["firstName": self.userFirstName])
                    userPath.setValue(["lastName": self.userLastName])
                    userPath.setValue(["birthday": self.userBirthday])
                    userPath.setValue(["zipCode": self.userZipCode])
                    userPath.setValue(["phoneNumber": self.userPhoneNumber])
                }
                else {
                    self.show(errorMessage: "Failed to create user")
                }
            }
            
            self.performSegue(withIdentifier: "verified", sender: self)
        }
        else {
            self.show(errorMessage: "Invalid phone number. Please try again")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // hides keyboard
        self.phoneNumberTextField.resignFirstResponder()
        return true
    }

    func show(errorMessage message: String) -> Void {
        let errAlertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        errAlertController.addAction(okAction)
        
        self.present(errAlertController, animated: true, completion: nil)
    }
    
    func phoneNumberIsValid() -> Bool {
        if let phone = self.phoneNumberTextField.text {
            if phone == "" {
                self.show(errorMessage: "Phone number cannot be left blank")
                return false
            }
            else {
                let toCheck = phone.components(separatedBy: CharacterSet.whitespaces).joined().replacingOccurrences(of: "-", with: "")
                
                for num in toCheck.unicodeScalars {
                    if !(CharacterSet.decimalDigits.contains(num)) {
                        return false
                    }
                }
                
            }
        }
        else {
            return false
        }
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.phoneNumberTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
