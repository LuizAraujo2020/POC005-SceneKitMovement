//
//  GeometryComponent.swift
//  ECSPractice01
//
//  Created by Luiz Araujo on 18/05/23.
//

import GameplayKit
import SceneKit

class GeometryComponent: GKComponent {
    
    /// A reference to the bounderies in the scene that the entity controls.
    /// A reference to the box in the scene that the entity controls.
    var geometryNode: SCNNode
    
    init(geometryNode: SCNNode) {
        self.geometryNode = geometryNode
        super.init()
    }
    
    func change(location point: SCNVector3) {
        guard geometryNode.position.x != point.x &&
        geometryNode.position.y != point.y &&
        geometryNode.position.z != point.z else { return }
        
        geometryNode.position = point
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class SomeStateMachine: GKStateMachine {
    
}
