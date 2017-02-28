//
//  VerifyViewController.swift
//  PayForwardTest
//
//  Created by Sarthak Khillon on 2/28/17.
//  Copyright © 2017 Sarthak Khillon. All rights reserved.
//

import UIKit
import FirebaseAuth

class VerifyViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Connectors
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var policyLabel: UILabel!
    
    // User Information
    var userFirstName: String?
    var userLastName: String?
    var userBirthday: String?
    var userZipCode: String?
    var userEmail: String?
    var userPassword: String?
    
    @IBAction func verifyButtonTapped(_ sender: Any) {
        if phoneNumberIsValid() {
            FIRAuth.auth()?.createUser(withEmail: self.userEmail!, password: self.userPassword!) { (user, error) in
                
                if error == nil {
                    print("Successful sign up")
                    // TODO: persist data to user profile
                    self.performSegue(withIdentifier: "verified", sender: self)
                }
                else {
                    let errAlertController = UIAlertController(title: "Error", message: "Failed to create user", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    errAlertController.addAction(okAction)
                    self.present(errAlertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // hides keyboard
        self.phoneNumberTextField.resignFirstResponder()
        return true
    }

    func phoneNumberIsValid() -> Bool {
        // TODO
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
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let newVC = segue.destination as! UserViewController
        newVC.userID = FIRAuth.auth()?.currentUser?.uid
    }
 

}
