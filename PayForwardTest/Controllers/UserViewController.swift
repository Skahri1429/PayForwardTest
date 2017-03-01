//
//  UserViewController.swift
//  PayForwardTest
//
//  Created by Pankaj Khillon on 2/28/17.
//  Copyright © 2017 Sarthak Khillon. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class UserViewController: UIViewController {
    
    var ref = FIRDatabase.database().reference()

    // MARK: Connectors
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var zipCodeLabel: UILabel!
    
    @IBOutlet weak var birthdayLabel: UILabel!
    
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        do {
            try FIRAuth.auth()?.signOut()
            self.performSegue(withIdentifier: "logout", sender: self)
        }
        catch {
            print("Error logging out")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let currentUser = FIRAuth.auth()?.currentUser
        
        ref.child("users").child((currentUser?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let firstName = value?["firstName"] as? String ?? "No First Name Found" // nil coalescing operator with fallback output which should never run but I'm keeping for debugging purposes.
            let lastName = value?["lastName"] as? String ?? "No Last Name Found"
            
            self.idLabel.text = currentUser?.uid
            self.nameLabel.text = "\(firstName) \(lastName)"
            self.emailLabel.text = (currentUser?.email)! as String
            self.phoneLabel.text = value?["phoneNumber"] as? String ?? "No phone number found"
            self.zipCodeLabel.text = value?["zipCode"] as? String ?? "No Zip Code found"
            self.birthdayLabel.text = value?["birthday"] as? String ?? "No birthday found"
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
