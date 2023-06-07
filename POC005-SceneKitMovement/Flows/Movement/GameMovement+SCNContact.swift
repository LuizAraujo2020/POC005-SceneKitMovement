//
//  GameMovement+SCNContact.swift
//  POC005-SceneKitMovement
//
//  Created by Luiz Araujo on 06/06/23.
//

import SceneKit

extension GameMovement: SCNPhysicsContactDelegate {

    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        
        let playerMask = playerNode.physicsBody?.categoryBitMask
        let nodeA = contact.nodeA.physicsBody?.categoryBitMask
        let nodeB = contact.nodeB.physicsBody?.categoryBitMask
        
        if nodeA == playerMask || nodeB == playerMask {
        
            if nodeA == PhysicsCategories.ball.rawValue {
                contact.nodeA.removeFromParentNode()
                DispatchQueue.main.async {
                    self.count += 1
                }
                
            } else if nodeB == PhysicsCategories.ball.rawValue {
                contact.nodeB.removeFromParentNode()
                DispatchQueue.main.async {
                    self.count += 1
                }
            }
        }
    }
}
