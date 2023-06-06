//
//  PlayerNode.swift
//  POC005-SceneKitMovement
//
//  Created by Luiz Araujo on 05/06/23.
//

import SceneKit

final class PlayerNode: SCNNode {
    
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
    let speed = Float(0.1)

    override init() {
        super.init()

        // create player
        let playerGeometry = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
        playerGeometry.firstMaterial?.diffuse.contents = UIColor.brown

        position = SCNVector3(x: 0, y: 0.5, z: 0)

        // give the looks
        geometry = playerGeometry

        // define shape, here a box around the player
        let shape = SCNPhysicsShape(
            geometry: playerGeometry,
            // default is box, give it a physics shape near to its looking shape
            options: [SCNPhysicsShape.Option.type: SCNPhysicsShape.ShapeType.boundingBox]
        )

        // assign physics body based on geometry body (here: player)
        physicsBody = SCNPhysicsBody(type: .kinematic, shape: shape)
        physicsBody?.angularVelocityFactor = SCNVector3Zero
    }
    
    func walkingDirection(_ direction: SIMD3<Float>) {
        let currentPosition = SIMD3(
            x: self.position.x,
            y: self.position.y,
            z: self.position.z)
        
        position.x = currentPosition.x + direction.x * speed
        position.y = currentPosition.y + direction.y * speed
        position.z = currentPosition.z + direction.z * speed
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

