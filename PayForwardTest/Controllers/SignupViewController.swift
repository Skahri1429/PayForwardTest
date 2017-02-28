//
//  SignupViewController.swift
//  PayForwardTest
//
//  Created by Sarthak Khillon on 2/28/17.
//  Copyright © 2017 Sarthak Khillon. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, UITextFieldDelegate {

    // MARK: Connections
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var userBirthday: Date!
    
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        if firstNameIsValid() && lastNameIsValid() && birthdayIsValid() && zipCodeIsValid() && emailIsValid() && passwordIsValid() {
            print("All fields valid")
            
            // TODO: Add these fields to Firebase user profile
            
            self.performSegue(withIdentifier: "submit", sender: self)
        }
        else {
            // NOTE: Again, more robust error handling later.
            let errController = UIAlertController(title: "Error", message: "One of the fields is not valid", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            errController.addAction(okAction)
            
            self.present(errController, animated: true, completion: nil)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    // MARK: Custom functions
    func firstNameIsValid() -> Bool {
        // TODO
        return true
    }
    
    func lastNameIsValid() -> Bool {
        // TODO
        return true
    }
    
    func birthdayIsValid() -> Bool {
        // TODO
        return true
    }
    
    func zipCodeIsValid() -> Bool {
        // TODO
        return true
    }
    
    func emailIsValid() -> Bool {
        // TODO
        return true
    }
    
    func passwordIsValid() -> Bool {
        // TODO
        return true
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        birthdayTextField.delegate = self
        zipCodeTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newVC = segue.destination as! VerifyViewController
        newVC.userFirstName = self.firstNameTextField.text!
        newVC.userLastName = self.lastNameTextField.text!
        newVC.userBirthday = self.birthdayTextField.text! // TODO: needs to be replaced with Date object
        newVC.userZipCode = self.zipCodeTextField.text!
        newVC.userEmail = self.emailTextField.text!
        newVC.userPassword = self.passwordTextField.text!
    }
 

}
