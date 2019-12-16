//
//  SignupViewController.swift
//  SkyWalkYYCProto
//
//  Created by Siddharth Kataria on 2019-12-15.
//  Copyright © 2019 Siddharth Kataria. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class SignupViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements() {
        //Hiding Error Label
        errorLabel.alpha = 0
        UtilitiesText.styleTextField(firstNameTextField)
        UtilitiesText.styleTextField(lastNameTextField)
        UtilitiesText.styleTextField(emailTextField)
        UtilitiesText.styleTextField(passwordTextField)
        UtilitiesText.styleFilledButton(signUpButton)
    }
    
    // Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        // Check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if UtilitiesText.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
    }
    
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    
    @IBAction func signUpTapped(_ sender: Any) {
            
        // Validate the fields
        let error = validateFields()
        
        if error != nil {
            
            // There's something wrong with the fields, show error message
            showError(error!)
        }
        else {
            
            // Create cleaned versions of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                // Check for errors
                if err != nil {
                    
                    // There was an error creating the user
                    self.showError("Error creating user")
                }
                else {
                    
                    // User was created successfully, now store the first name and last name
                    let db = Firestore.firestore()
                
                    db.collection("users").addDocument(data: ["firstName":firstName, "lastName":lastName,"points":0, "uid": result!.user.uid ]) 
                    
                    // Transition to the home screen
                    self.transitionToHome()
                }
            }
        }
    }
    
    func transitionToHome() {
        let homeViewController = storyboard?.instantiateViewController(identifier: "MainVC") as? OriginalViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
    @IBAction func doneFN(_ sender: Any) {
        (sender as AnyObject).resignFirstResponder()
    }
    @IBAction func doneLN(_ sender: Any) {
        (sender as AnyObject).resignFirstResponder()
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
