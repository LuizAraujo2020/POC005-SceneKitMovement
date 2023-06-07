//
//  BallNode.swift
//  POC005-SceneKitMovement
//
//  Created by Luiz Araujo on 06/06/23.
//

import SceneKit

final class BallNode: SCNNode {
    
    init(position: SCNVector3 = SCNVector3(
        x: 0,
        y: 0.5,
        z: 2)) {
            super.init()
                        
            let nodeGeometry = SCNSphere(radius: 0.5)
            nodeGeometry.firstMaterial?.diffuse.contents = UIColor.red
            
            self.position = position
            
            // give the looks
            geometry = nodeGeometry
            
            let shape = SCNPhysicsShape(geometry: nodeGeometry)

            physicsBody = SCNPhysicsBody(type: .static, shape: shape)
            physicsBody?.angularVelocityFactor = SCNVector3Zero
            physicsBody?.categoryBitMask = PhysicsCategories.ball.rawValue
            physicsBody?.contactTestBitMask = PhysicsCategories.player.rawValue
            physicsBody?.collisionBitMask = PhysicsCategories.ground.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


