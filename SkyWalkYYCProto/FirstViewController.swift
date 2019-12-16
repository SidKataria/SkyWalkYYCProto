//
//  FirstViewController.swift
//  SkyWalkYYCProto
//
//  Created by Siddharth Kataria on 2019-12-15.
//  Copyright © 2019 Siddharth Kataria. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements() {
        UtilitiesText.styleFilledButton(signUpButton)
        UtilitiesText.styleFilledButton(logInButton)
         
    }

    //Unwinding
    @IBAction func unwinding(unwindSegue: UIStoryboardSegue) {
        
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
