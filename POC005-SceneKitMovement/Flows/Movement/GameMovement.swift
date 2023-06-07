//
//  GameMovement.swift
//  POC005-SceneKitMovement
//
//  Created by Luiz Araujo on 04/06/23.
//

import UIKit
import SwiftUI
import SceneKit
import GameplayKit

enum PhysicsCategories: Int {
    case player = 1, mob = 2, ground = 4, wall = 8, ball = 16

//    static let player : UInt32 = 0x1 << 0
//    static let mob : UInt32 = 0x1 << 1
//    static let ground : UInt32 = 0x1 << 2
//    static let wall : UInt32 = 0x1 << 4
//    static let tile : UInt32 = 0x1 << 8
//    //        static let edgeLoop : UInt32 = 0x1 << 4
//    //        static let Frame : UInt32 = 0x1 << 8
}

@MainActor
final class GameMovement: NSObject, ObservableObject {
    
    var scene   = SCNScene()
    var skScene: SKScene!
    
    let playerNode = PlayerNode()
    let npcNode    = NPCNode(position: MechanicNPC.questHideNSeekPosition)
    let cameraNode = CameraNode()
    
    var direction = SIMD2(Double.zero, Double.zero)
    
    @Published var isDragging = false
    @Published var count = 0
    
    /// Animation
    var animations = [String: CAAnimation]()
    var idle = 0
    
    override init() {
        super.init()
        
        scene.physicsWorld.contactDelegate = self
        
        let lightNode = LightNode()
        let floorNode = FloorNode()
        
        scene.rootNode.addChildNode(lightNode)
        scene.rootNode.addChildNode(cameraNode)
        scene.rootNode.addChildNode(floorNode)
        scene.rootNode.addChildNode(playerNode)
        scene.rootNode.addChildNode(npcNode)
        
        setup2DOverlay()
        generateBalls()
//        test()
        
        // Load the DAE animations
        loadAnimations()
    }
    
    func loadAnimations () {
//        // Load the character in the idle animation
//        let node = SCNNode(named: "idleFixedCopy.scn")
//
//        // This node will be parent of all the animation models
////        let node = SCNNode()
//
////        // Add all the child nodes to the parent node
////        for child in idleScene.rootNode.childNodes {
////            node.addChildNode(child)
////        }
//
//        // Set up some properties
//        node.position = SCNVector3(0, -1, -2)
//        node.scale = SCNVector3(0.2, 0.2, 0.2)
//
//        // Add the node to the scene
//        scene.rootNode.addChildNode(node)
        
        
        animations["idle"] = animationFromSceneNamed(path: "idleFixedCopy.scn")
        animations["pick"] = animationFromSceneNamed(path: "pickFixed.scn")
        animations["walk"] = animationFromSceneNamed(path: "walkFixed.scn")

        
//        // Load all the DAE animations
//        loadAnimation(withKey: "pickFixed", sceneName: "pickFixed", animationIdentifier: "pickFixed-1")
//        print("loadAnimation: \(animations)")
    }
    
    func loadAnimation(withKey: String, sceneName:String, animationIdentifier:String) {
        let sceneURL = Bundle.main.url(forResource: sceneName, withExtension: "scn")
//        print("sceneURL: \(sceneURL)")
       
        let sceneSource = SCNSceneSource(url: sceneURL!, options: nil)
//        print("sceneSource: \(sceneSource)")
        guard let an = sceneSource else { return }
        
//        if let animationObject = an.entryWithIdentifier(animationIdentifier, withClass: CAAnimation.self) {
//            // The animation will only play once
//            animationObject.repeatCount = 1
//            // To create smooth transitions between animations
//            animationObject.fadeInDuration = CGFloat(1)
//            animationObject.fadeOutDuration = CGFloat(0.5)
//
//            // Store the animation for later use
//            animations[withKey] = animationObject
//        }
    }
    
    func playAnimation(key: String) {
        // Add the animation to start playing it right away
//        scene.rootNode.addAnimation(animations[key]!, forKey: key)
        playerNode.addAnimation(animations[key]!, forKey: key)
    }
    
    func stopAnimation(key: String) {
        // Stop the animation with a smooth transition
//        scene.rootNode.removeAnimation(forKey: key, blendOutDuration: CGFloat(0.5))
        playerNode.removeAnimation(forKey: key, blendOutDuration: CGFloat(0.5))
    }
    
    func animationFromSceneNamed(path: String) -> CAAnimation? {
        let scene  = SCNScene(named: path)
        var animation:CAAnimation?
        scene?.rootNode.enumerateChildNodes({ child, stop in
            if let animKey = child.animationKeys.first {
                animation = child.animation(forKey: animKey)
                stop.pointee = true
            }
        })
        return animation
    }
    
    private func test() {

//        let node = SCNNode(named: "idleFixedCopy.scn")
//        let node = SCNNode(named: "walkFixed.scn")
        let node = SCNNode(named: "pickFixed.scn")
        node.scale = SCNVector3(x: 0.05,
                                y: 0.05,
                                z: 0.05)
//        let node = SCNNode(named: "catalog.scnassets/SceneKit Scene.scn")
        node.position = SCNVector3(x: 0, y: 0.5, z: 0)
        
//        let nodes = myScene.rootNode.childNodes
//        for nde in nodes {
            scene.rootNode.addChildNode(node)
//        }
    }
    
    private func setup2DOverlay() {
        let viewWidth = UIScreen.main.bounds.size.width
        let viewHeight = UIScreen.main.bounds.size.height
        
        let sceneSize = CGSize(width: viewWidth, height: viewHeight)
        let skScene = SKScene(size: sceneSize)

        skScene.scaleMode = .resizeFill

        skScene.backgroundColor = .clear



        let dpadShape = SKShapeNode(circleOfRadius: 75)
        dpadShape.strokeColor = .white
        dpadShape.lineWidth = 2.0

        dpadShape.position.x = dpadShape.frame.size.width / 2 + 10
        dpadShape.position.y = dpadShape.frame.size.height / 2 + 10

        skScene.addChild(dpadShape)
        skScene.isUserInteractionEnabled = false

        //        overlaySKScene = skScene
    }

    func virtualDPad() -> CGRect {
        var vDPad = CGRect(x: 0, y: 0, width: 150, height: 150)

        vDPad.origin.y = UIScreen.main.bounds.size.height - vDPad.size.height - 10
        vDPad.origin.x = 10

        return vDPad
    }
    
    private func generateBalls() {
        var array = [Float]()
        
        for i in 0...100 {
            array.append(Float(i))
        }
        
        
        
        let randSource = GKRandomSource()
        let arrayX = randSource.arrayByShufflingObjects(in: array)
        let arrayZ = randSource.arrayByShufflingObjects(in: array)
        
        for i in 0..<array.count {
            var position = MechanicNPC.questHideNSeekPosition
            position.x = arrayX[i] as! Float
            position.y = 1
            position.z = arrayZ[i] as! Float
            
            let ball = BallNode(position: position)
            
            self.scene.rootNode.addChildNode(ball)
        }
    }
    
}

extension GameMovement: SCNSceneRendererDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if isDragging {
            let directionInV3 = SIMD3(x: Float(direction.x),
                                      y: Float(0),
                                      z: Float(direction.y))
            playerNode.walkingDirection(directionInV3)
            
            cameraNode.position.x = playerNode.presentation.position.x
            cameraNode.position.z = playerNode.presentation.position.z + CameraNode.offset
        }
    }
}

/// Resource
/// https://stackoverflow.com/questions/46514800/xcode9-scenekit-dae-file-not-loading-into-scnscene-returns-nil
extension SCNNode {

    convenience init(named name: String) {
        self.init()

        guard let scene = SCNScene(named: name) else {
            print("❌❌DEu ruim ")
            return
        }

        for childNode in scene.rootNode.childNodes {
            addChildNode(childNode)
        }
    }

}
