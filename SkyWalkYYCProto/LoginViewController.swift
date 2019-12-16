//
//  LoginViewController.swift
//  SkyWalkYYCProto
//
//  Created by Siddharth Kataria on 2019-12-15.
//  Copyright © 2019 Siddharth Kataria. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements() {
        errorLabel.alpha = 0 
        UtilitiesText.styleTextField(emailTextField)
        UtilitiesText.styleTextField(passwordTextField)
        UtilitiesText.styleFilledButton(logInButton)
    }
    @IBAction func logInTapped(_ sender: Any) {
            
            // TODO: Validate Text Fields
            
            // Create cleaned versions of the text field
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Signing in the user
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                
                if error != nil {
                    // Couldn't sign in
                    self.errorLabel.text = error!.localizedDescription
                    self.errorLabel.alpha = 1
                }
                else {
                    
                    let homeViewController = self.storyboard?.instantiateViewController(identifier: "MainVC") as? OriginalViewController
                    
                    self.view.window?.rootViewController = homeViewController
                    self.view.window?.makeKeyAndVisible()
                }
            }
        }
    
    @IBAction func doneEmail(_ sender: Any) {
        (sender as AnyObject).resignFirstResponder()
    }
    @IBAction func donePass(_ sender: Any) {
        (sender as AnyObject).resignFirstResponder()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
