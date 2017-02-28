//
//  LoginViewController.swift
//  PayForwardTest
//
//  Created by Sarthak Khillon on 2/28/17.
//  Copyright © 2017 Sarthak Khillon. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Connectors
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    // MARK: Custom functions
    func login(email: String, password: String) -> Void {
        if email == "" || password == "" {
            self.presentBadLoginError()
        }
        else {
            FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
                if error != nil {
                    self.presentBadLoginError()
                    print("Login authentication error: \(error)")
                }
                else {
                    let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUp")
                    self.present(nextVC!, animated: true, completion: nil)
                    print("Login successful")
                }
            }
        }
    }
    
    // NOTE: We can customize error handling later, I just wanted a generic for now.
    func presentBadLoginError() -> Void {
        let errAlertController = UIAlertController(title: "Error", message: "Please enter a valid email address and password", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        errAlertController.addAction(okAction)
        
        self.present(errAlertController, animated: true, completion: nil)
    }
    
    // MARK: Text Field delegate functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.emailTextField {
            self.passwordTextField.becomeFirstResponder()
        }
        else if textField == self.passwordTextField {
            login(email: self.emailTextField.text!, password: self.passwordTextField.text!)
        }
        
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
