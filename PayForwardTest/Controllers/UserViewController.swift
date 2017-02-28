//
//  UserViewController.swift
//  PayForwardTest
//
//  Created by Pankaj Khillon on 2/28/17.
//  Copyright © 2017 Sarthak Khillon. All rights reserved.
//

import UIKit
import FirebaseAuth

class UserViewController: UIViewController {

    @IBOutlet weak var idLabel: UILabel!
    
    var userID: String?
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        do {
            try FIRAuth.auth()?.signOut()
            self.performSegue(withIdentifier: "logout", sender: self)
        } catch {
            print("Error logging out")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.idLabel.text = userID
        // Do any additional setup after loading the view.
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
