//
//  MovementComponent.swift
//  ECSPractice01
//
//  Created by Luiz Araujo on 18/05/23.
//

import GameplayKit
import SceneKit

class MovementComponent: GKComponent {
    
    /// A convenience property for the entity's geometry component.
    var geometryComponent: GeometryComponent? {
        return entity?.component(ofType: GeometryComponent.self)
    }
    
    func move(_ point: SCNVector3) {
        guard let geo = geometryComponent else { return }
        guard geo.geometryNode.position.x != point.x ||
                geo.geometryNode.position.y != point.y ||
                geo.geometryNode.position.z != point.z else { return }
        
        let moveAction = SCNAction.move(to: point, duration: 1.5)
        moveAction.timingMode = SCNActionTimingMode.easeInEaseOut // suaviza a animacao
        geo.geometryNode.runAction(moveAction)        
    }
}
