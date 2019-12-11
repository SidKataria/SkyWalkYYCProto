//
//  PointsScene.swift
//  SkyWalkYYCProto
//
//  Created by Siddharth Kataria on 2019-11-24.
//  Copyright © 2019 Siddharth Kataria. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

class PointsScene: SCNNode  {
    func loadModal() {
        guard let virtualObjectScene = SCNScene(named: "art.scnassets/point.scn") else {return}
        
        let wrapperNode = SCNNode()
        
        for child in virtualObjectScene.rootNode.childNodes {
            wrapperNode.addChildNode(child)
        }
        
        self.addChildNode(wrapperNode)
    }
    
}
