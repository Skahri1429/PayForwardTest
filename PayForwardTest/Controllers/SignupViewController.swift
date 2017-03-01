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
        if firstNameIsValid() && lastNameIsValid() && /*birthdayIsValid() &&*/ zipCodeIsValid() && emailIsValid() && passwordIsValid() {
            print("All fields valid")
            
            self.performSegue(withIdentifier: "submit", sender: self)
        }
        else {
            print("not valid")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // MARK: Custom functions
    
    func show(errorMessage message: String) -> Void {
        let errAlertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        errAlertController.addAction(okAction)
        
        self.present(errAlertController, animated: true, completion: nil)
    }

    func birthdayToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        return dateFormatter.string(from: date)
    }
    func firstNameIsValid() -> Bool {
       
        if let firstName = self.firstNameTextField.text {
            if firstName == "" {
                self.show(errorMessage: "First name cannot be blank")
            }
            
            for c in (firstName.unicodeScalars) {
                if !(NSCharacterSet.letters.contains(c)) {
                    self.show(errorMessage: "Invalid first name")
                    return false
                }
            }
        }
        else {
            self.show(errorMessage: "First name cannot be blank")
            return false
        }
        
        return true
    }
    
    func lastNameIsValid() -> Bool {
        
        if let lastName = self.lastNameTextField.text {
            if lastName == "" {
                self.show(errorMessage: "Last name cannot be blank")
            }
            
            for c in (lastName.unicodeScalars) {
                if !(NSCharacterSet.letters.contains(c)) {
                    self.show(errorMessage: "Invalid last name")
                    return false
                }
            }
        }
        else {
            self.show(errorMessage: "Last name cannot be blank")
            return false
        }
        
        return true
    }
    
//    func birthdayIsValid() -> Bool {
//
//        return true
//    }
    
    func zipCodeIsValid() -> Bool {
        if let zip = self.zipCodeTextField.text {
            let zipCode = zip.trimmingCharacters(in: CharacterSet.whitespaces)
            if zipCode.characters.count != 5 {
                self.show(errorMessage: "Zip code must be 5 numbers long")
                return false
            }
            else {
                for c in (zipCode.unicodeScalars) {
                    if !(NSCharacterSet.decimalDigits.contains(c)) {
                        self.show(errorMessage: "Zip code must be all numbers")
                        return false
                    }
                }
            }
        }
        else {
            self.show(errorMessage: "Zip code cannot be blank")
            return false
        }
        
        return true
    }
    
    func emailIsValid() -> Bool {
        // Regex taken from http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
        let valid: Bool!
        if let email = self.emailTextField.text {
            if email == "" {
                self.show(errorMessage: "Email field cannot be blank")
                return false
            }
            else {
                let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
                
                let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
                valid = emailTest.evaluate(with: email)
                
                if !valid {
                    self.show(errorMessage: "Email format incorrect")
                }
            }
        }
        else {
            self.show(errorMessage: "Email field cannot be blank")
            valid = false
        }
        
        return valid
    }
    
    func passwordIsValid() -> Bool {
        if let pass = self.passwordTextField.text {
            let password = pass.trimmingCharacters(in: CharacterSet.whitespaces)
            if password.characters.count < 8 {
                self.show(errorMessage: "Password must be a minimum of 8 characters long")
                return false
            }
        }
        else {
            self.show(errorMessage: "Password cannot be blank")
            return false
        }
        return true
    }
    
    func updateDate(_ datePicker: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, YYYY"
        
        self.birthdayTextField.text = formatter.string(from: datePicker.date)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.birthdayTextField.delegate = self
        self.zipCodeTextField.delegate = self
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        self.birthdayTextField.inputView = datePicker
        
        datePicker.addTarget(self, action: #selector(SignupViewController.updateDate(_:)), for: .valueChanged)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newVC = segue.destination as! VerifyViewController
        newVC.userFirstName = self.firstNameTextField.text!
        newVC.userLastName = self.lastNameTextField.text!
        newVC.userBirthday = self.birthdayTextField.text!
        newVC.userZipCode = self.zipCodeTextField.text!
        newVC.userEmail = self.emailTextField.text!
        newVC.userPassword = self.passwordTextField.text!
    }
 

}
