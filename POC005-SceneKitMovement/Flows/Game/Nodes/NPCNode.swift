//
//  NPCNode.swift
//  POC005-SceneKitMovement
//
//  Created by Luiz Araujo on 06/06/23.
//

import SceneKit

final class NPCNode: SCNNode {
    
    var directionAngle: SCNFloat = 0.0 {
        didSet {
            if directionAngle != oldValue {
                // Action that rotates the node to an angle in radian.
                let action = SCNAction.rotateTo(
                    x: 0.0, y: CGFloat(directionAngle), z: 0.0,
                    duration: 0.1,
                    usesShortestUnitArc: true)
                runAction(action)
            }
        }
    }
    //    let speed = Float(0.1)
    
    init(position: SCNVector3 = SCNVector3(
        x: 0,
        y: 0.5,
        z: 2)) {
            super.init()
            
            // create player
            let nodeGeometry = SCNBox(width: 1, height: 2, length: 1, chamferRadius: 0)
            nodeGeometry.firstMaterial?.diffuse.contents = UIColor.blue
            
            self.position = position
            
            // give the looks
            geometry = nodeGeometry
            
            // define shape, here a box around the player
            let shape = SCNPhysicsShape(
                geometry: nodeGeometry,
                // default is box, give it a physics shape near to its looking shape
                options: [SCNPhysicsShape.Option.type: SCNPhysicsShape.ShapeType.boundingBox]
            )
            
            // assign physics body based on geometry body (here: player)
            physicsBody = SCNPhysicsBody(type: .dynamic, shape: shape)
            physicsBody?.angularVelocityFactor = SCNVector3Zero
            physicsBody?.categoryBitMask = PhysicsCategories.mob.rawValue
            physicsBody?.contactTestBitMask = PhysicsCategories.player.rawValue | PhysicsCategories.ground.rawValue
            physicsBody?.collisionBitMask = PhysicsCategories.player.rawValue | PhysicsCategories.ground.rawValue
    }
    
    private func createRange() {
        
        // create circle
        let nodeGeometry = SCNSphere(radius: 1)
        nodeGeometry.firstMaterial?.diffuse.contents = UIColor.gray
        
        self.position = position
        
        // give the looks
        geometry = nodeGeometry
        
        // define shape, here a box around the player
//        let shape = SCNPhysicsShape(
//            geometry: nodeGeometry,
//            // default is box, give it a physics shape near to its looking shape
//            options: [SCNPhysicsShape.Option.type: SCNPhysicsShape.ShapeType.boundingSphere]
//        )
        let shape = SCNPhysicsShape(geometry: nodeGeometry)

//        Criar fisica que criar aura para contato com player

        let node = SCNNode()
        node.physicsBody = SCNPhysicsBody(type: .dynamic, shape: shape)
        
        
        // assign physics body based on geometry body (here: player)
        node.physicsBody = SCNPhysicsBody(type: .kinematic, shape: shape)
        node.physicsBody?.angularVelocityFactor = SCNVector3Zero
        node.physicsBody?.categoryBitMask    = PhysicsCategories.mob.rawValue
        node.physicsBody?.contactTestBitMask = PhysicsCategories.player.rawValue
        
        self.addChildNode(node)
    }
    
    func walkingDirection(_ direction: SIMD3<Float>) {
        let currentPosition = SIMD3(
            x: self.position.x,
            y: self.position.y,
            z: self.position.z)
        
        position.x = currentPosition.x + direction.x// * speed
        position.y = currentPosition.y + direction.y// * speed
        position.z = currentPosition.z + direction.z// * speed
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


