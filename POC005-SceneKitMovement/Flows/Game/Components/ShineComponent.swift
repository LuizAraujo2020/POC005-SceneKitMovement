//
//  ShineComponent.swift
//  ECSPractice01
//
//  Created by Luiz Araujo on 18/05/23.
//

import SpriteKit
import SceneKit
import GameplayKit

class ShineComponent: GKComponent {
    // MARK: Properties

    /// A convenience property to access the entity's geometry component.
    var geometryComponent: GeometryComponent? {
        return entity?.component(ofType: GeometryComponent.self)
    }
    
    /// The light attached to the box that illuminates its surroundings.
    let boxLight = SCNLight()

    /// The brightness of the box's light. Changes the light's brightness when changed.
    var lightBrightness: CGFloat = 1 {
        didSet {
            boxLight.color = SKColor(white: lightBrightness, alpha: 1)
        }
    }
    
    var isHighlighted: Bool = false {
        didSet {
            if isHighlighted {
                highlight()
            } else {
                unHighlight()
            }
        }
    }
    
    // MARK: Methods
    
    override func update(deltaTime _: TimeInterval) { }
    
    private func highlight() {
        guard let geo = geometryComponent else { return }
        
        // get its material
        let material = geo.geometryNode.geometry!.firstMaterial!
        
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.5
        
        material.emission.contents = UIColor.red
        
        SCNTransaction.commit()
    }
    
    private func unHighlight() {
        guard let geo = geometryComponent else { return }
        
        // get its material
        let material = geo.geometryNode.geometry!.firstMaterial!
        
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.5
        
        material.emission.contents = UIColor.black
        
        SCNTransaction.commit()
    }
}
