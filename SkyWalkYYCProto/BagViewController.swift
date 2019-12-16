//
//  BagViewController.swift
//  SkyWalkYYCProto
//
//  Created by Favian Silva on 2019-12-15.
//  Copyright © 2019 Siddharth Kataria. All rights reserved.
//

import UIKit

class BagViewController: UIViewController, UITableViewDelegate , UITableViewDataSource{
    
    var points = 0

    var store = ["Starbucks", "JugoJuice", "McDonalds","A&W","Brass Monocle","Fido", "Second Cup","Rogers","Leons", "New York Frys"]
    
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var storeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        pointsLabel.text = "Points: \(points)"
        // Do any additional setup after loading the view.\
        storeTableView.delegate = self
        storeTableView.dataSource = self
    }
    

        // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return store.count
    }

        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StoreCell", for: indexPath)

            //let theStore = storeArray[indexPath.row]
            
            cell.textLabel?.text = store[indexPath.row]
       // cell.imageView?
            
            return cell
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
