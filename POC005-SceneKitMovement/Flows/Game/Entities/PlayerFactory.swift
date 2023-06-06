//
//  PlayerFactory.swift
//  ECSPractice01
//
//  Created by Luiz Araujo on 19/05/23.
//

import GameplayKit

class PlayerFactory {
    
//    enum TypeOfTile {
//        case neutral, good, bad, question
//    }
    
    func create(name: String = "",
                color: UIColor = .green,
                position: SCNVector3 = SCNVector3.init()) -> GKEntity {
        
        let entity = GKEntity()
        
        let tileMaterial = SCNMaterial()
        tileMaterial.diffuse.contents = color
            
        let cone = SCNCone(topRadius: 0, bottomRadius: 0.25, height: 1)
        let tile = SCNNode(geometry: cone)
        tile.geometry!.materials = [tileMaterial]
        tile.position = position
        
        // MARK: Create and attach a Components to the node.
        
        let geometryComponent = GeometryComponent(geometryNode: tile)
        entity.addComponent(geometryComponent)
        
        let moveComponent = MovementComponent()
        entity.addComponent(moveComponent)
        
        /// Physics is needed to collision and contact.
        let physicsComponent = PhysicsComponent(category: .tile, contact: .Player, collision: .Player)
        entity.addComponent(physicsComponent)
        
        let shineComponent = ShineComponent()
        entity.addComponent(shineComponent)

        return entity
    }
}
