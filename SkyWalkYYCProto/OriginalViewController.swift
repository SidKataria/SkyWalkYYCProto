//
//  ViewController.swift
//  SkyWalkYYCProto
//
//  Created by Siddharth Kataria on 2019-11-05.
//  Copyright © 2019 Siddharth Kataria. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import MapKit
import CoreLocation
import Firebase


class ViewController: UIViewController, ARSCNViewDelegate, CLLocationManagerDelegate, SCNPhysicsContactDelegate {
    let locationManager = CLLocationManager()
  
    @IBOutlet weak var pointsDisplay: UILabel!
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var miniMap: MKMapView!
    @IBOutlet weak var pointsLabel: UILabel!
    
    var totalPoints = 0 {
        didSet {
            pointsLabel.text = "Points: \(totalPoints)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Customizing the map
        bottomView.layer.cornerRadius = (bottomView.frame.size.width/2 + 10)
        bottomView.clipsToBounds = true
        bottomView.layer.borderColor = UIColor.black.cgColor
        bottomView.layer.borderWidth = 5.0
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        // Set the view's delegate
        sceneView.delegate = self
        sceneView.scene.physicsWorld.contactDelegate = self
    }
    
    
    //Unwinding
    @IBAction func unwinding(unwindSegue: UIStoryboardSegue) {
        
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        //locationLabel.text = "locations = \(locValue.latitude) \n \(locValue.longitude)"
        miniMap.region = MKCoordinateRegion(center: locValue, span: MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
        
        addObject()
    }
    
    func addObject() {
        let point = PointsScene()
        point.loadModal()
        
        let xPos = randomPosition(lowerBound: -3, upperBound: 3)
        let yPos = randomPosition(lowerBound: -3, upperBound: 3)
        let zPos = randomPosition(lowerBound: -3, upperBound: 3)

        
        point.position = SCNVector3(x: xPos, y: yPos, z: zPos)
        point.runAction(SCNAction.repeat(SCNAction.rotateBy(x: 0, y: 1, z: 0, duration: 1), count: 2000))
        sceneView.scene.rootNode.addChildNode(point)
        
    }
    
    func randomPosition(lowerBound lower:Float, upperBound upper:Float) -> Float {
        return Float(arc4random()) / Float(UInt32.max) * (lower - upper) + upper
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: sceneView)
            let hitList = sceneView.hitTest(location, options: nil)
            
            if let hitObject = hitList.first {
                 let node = hitObject.node
                
                if node.name == "point" {
                    totalPoints += 1
                    node.removeFromParentNode()
                    addObject()
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // segue ViewControllerB -> ViewController
    @IBAction func unwindToThisView(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? MapViewController {
            if sourceViewController.route != nil {
                
                //miniMap.addOverlay(sourceViewController.route!.polyline)
                //miniMap.setVisibleMapRect(sourceViewController.route!.polyline.boundingMapRect, animated: true)
                //pointsLabel.text = "You're back with directions"
            }
        }
    }
    
    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
