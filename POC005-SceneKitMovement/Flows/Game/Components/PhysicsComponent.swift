//
//  PhysicsComponent.swift
//  ECSPractice01
//
//  Created by Luiz Araujo on 18/05/23.
//

import GameplayKit
import SceneKit

class PhysicsComponent: GKComponent {
    
    /// A convenience property for the entity's geometry component.
    var geometryComponent: GeometryComponent? {
        return entity?.component(ofType: GeometryComponent.self)
    }
    
    init(category: PhysicsCategory,
         contact: PhysicsCategory,
         collision: PhysicsCategory,
         type: SCNPhysicsBodyType = .static) {
        super.init()
        
        guard let geo = geometryComponent else { return }
        guard let shape = geo.geometryNode.geometry else { return }
        
        geo.geometryNode.physicsBody = SCNPhysicsBody(type: type, shape: SCNPhysicsShape(geometry: shape))
        geo.geometryNode.physicsBody!.categoryBitMask    = Int(category.rawValue)
        geo.geometryNode.physicsBody!.contactTestBitMask = Int(contact.rawValue)
        geo.geometryNode.physicsBody!.collisionBitMask   = Int(collision.rawValue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
