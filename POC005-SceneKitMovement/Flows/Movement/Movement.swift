//
//  Movement.swift
//  POC005-SceneKitMovement
//
//  Created by Luiz Araujo on 04/06/23.
//

import UIKit
import SwiftUI
import SceneKit
import GameplayKit

enum PhysicsCategory: Int {
    case Player = 1, Mob = 2, Ground = 4, Wall  = 8, tile = 16
}

class Movement: NSObject, ObservableObject {
    
    var scene = SCNScene()
    let skScene = SKScene(size: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
    
    let playerNode = PlayerNode()
    let cameraNode = CameraNode()
    
    var direction = SIMD2(Double.zero, Double.zero)
    
    @Published var isDragging = false
    
    override init() {
        super.init()
        
        setup2DOverlay()
        
        
        let lightNode = LightNode()
        let floorNode = FloorNode()
        
        scene.rootNode.addChildNode(lightNode)
        scene.rootNode.addChildNode(cameraNode)
        scene.rootNode.addChildNode(floorNode)
        scene.rootNode.addChildNode(playerNode)
    }
    
    private func setup2DOverlay() {
        let viewWidth = UIScreen.main.bounds.size.width
        let viewHeight = UIScreen.main.bounds.size.height
//        (size: CGSize(
//            width: bounds.size.width,
//            height: UIScreen.main.bounds.size.height))
//        let sceneSize = CGSize(width: viewWidth, height: viewHeight)
//        let skScene = SKScene(size: sceneSize)
        
        skScene.scaleMode = .resizeFill
        
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
}
                        
extension Movement: SCNSceneRendererDelegate {
    
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


//class Movement: ObservableObject {
//    // MARK: Properties
//
//
//    let scene = SCNScene()
//
//    var camera: SCNNode!
//    var ground: SCNNode!
//    var wall: SCNNode!
//    var players = [GKEntity]()
//    var tileEntities = [GKEntity]()
//
//    // MARK: - Game Logic
//    @Published var gameEnded = false
//
//    init() {
//        createPlayer()
//        createCamera()
//        createGround()
//    }
//
//    func movePlayer() {
//        guard !gameEnded else {
//            return
//        }
//
//
//        guard let move = players[0].component(ofType: MovementComponent.self)
//        else { return }
//
//
//        //TODO: Fazer certo
////        guard let name = tile.geometryNode.name else { return }
////        isShowingQuestion = name.contains("\(TileFactory.TypeOfTile.question.rawValue)")
////        if tileEntities[currentTile].component(ofType: QuestionComponent.self) != nil {
////
////        }
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//// MARK: - Creations
//extension Movement {
//
//    // MARK: Camera
//    private func createCamera() {
//        camera = SCNNode()
//        camera.camera = SCNCamera()
//        camera.name = "camera"
//        camera.position = SCNVector3(x: 0, y: 2, z: 0)
//        camera.rotate(
//            by: SCNQuaternion(0, -1, 0, 0),
//            aroundTarget: SCNVector3(0,0,-2.5))
//
//        scene.rootNode.addChildNode(camera)
//        scene.rootNode.addChildNode(ambientLight)
//    }
//
//    // MARK: Ground
//    private func createGround() {
//        let groundGeometry = SCNFloor()
//        /// Had to put this weird value because 0.0 was thowing in the console Log:
//        /// `Error: Pass FloorPass is not linked to the rendering graph and will be ignored check it's input/output`
//        groundGeometry.reflectivity = 0.00000000000001
//
//        let groundMaterial = SCNMaterial()
//        groundMaterial.diffuse.contents = UIColor.brown
//        groundGeometry.materials = [groundMaterial]
//
//        ground = SCNNode(geometry: groundGeometry)
//        ground.position.y = -0.055
//        ground.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: groundGeometry))
//        ground.physicsBody!.categoryBitMask    = PhysicsCategory.Ground.rawValue
//        ground.physicsBody!.contactTestBitMask = PhysicsCategory.Mob.rawValue
//        ground.physicsBody!.collisionBitMask   = PhysicsCategory.Mob.rawValue
//
//        scene.rootNode.addChildNode(ground)
//    }
//
//
//    // MARK: Player
//    func createPlayer() {
//        let asdf = SCNNode()
//
////        guard let pl = SCNScene(named: "catalog.scnassets/idleFixed.dae") else { fatalError("NAO CAREGOUUU")}
//
////        let node = SCNNode(named: "art.scnassets/house.dae")
//        let node = SCNNode(named: "art.scnassets/idleFixed.dae")
//
////        for childNode in pl!.rootNode.childNodes {
////            asdf.addChildNode(childNode)
////        }
//
//
//        node.position = SCNVector3(0,0.5,-8)
//
////        guard let node else { fatalError("NAo conseguiu achar a chid")}
//        scene.rootNode.addChildNode(node)
////        self.scene.rootNode.addChildNode(asdf)
//
//        let factory = PlayerFactory()
//        let ent = factory.create(
//            name: "player_1",
//            color: .yellow,
//            position: SCNVector3(0,0.5,-2))
//
//        guard let geo = ent.component(ofType: GeometryComponent.self) else { return }
//
//        scene.rootNode.addChildNode(geo.geometryNode)
//        self.tileEntities.append(ent)
//
//        players.append(ent)
//    }
//
//    var ambientLight: SCNNode {
//        let ambientLight = SCNLight()
//        ambientLight.type = .ambient
//        ambientLight.color = UIColor.white
//        ambientLight.intensity = 2000
//        ambientLight.categoryBitMask = -1
//
//        let ambientLightNode = SCNNode()
//        ambientLightNode.light = ambientLight
//        ambientLightNode.position = SCNVector3(x: 0, y: 5, z: 0)
//        return ambientLightNode
//    }
//
//    // Directional light creates shadows
//    var directionalLight: SCNNode {
//        let directionalLight = SCNLight()
//        directionalLight.type = .directional
//        directionalLight.castsShadow = true
//        directionalLight.color = UIColor.white
//        directionalLight.automaticallyAdjustsShadowProjection = true
//        directionalLight.shadowColor = UIColor.black.withAlphaComponent(0.5)
//        directionalLight.shadowMode = .deferred
//        directionalLight.shadowRadius = 8
//        directionalLight.zNear = 0
//        directionalLight.zFar = 50
//        directionalLight.shadowSampleCount = 32
//        directionalLight.shadowMapSize = CGSize(width: 4096, height: 4096)
//        directionalLight.categoryBitMask = -1
//
//        let directionalLightNode = SCNNode()
//        directionalLightNode.light = directionalLight
//        directionalLightNode.position = SCNVector3(x: 0, y: 15, z: 0)
//        directionalLightNode.eulerAngles = SCNVector3(deg2rad(-88), 0, deg2rad(-2))
//
//        return directionalLightNode
//    }
//}
//
//// MARK: - Helpers
//extension Movement {
//
//    private func rollDice() -> Int {
//        GKRandomSource().nextInt(upperBound: 6) + 1
//    }
//
//    func deg2rad(_ number: Float) -> Float {
//        return number * .pi / 180
//    }
//}
//
//
//
//extension SCNNode {
//
//    convenience init(named name: String) {
//        self.init()
//
//        guard let scene = SCNScene(named: name) else {
//            return
//        }
//
//        for childNode in scene.rootNode.childNodes {
//            addChildNode(childNode)
//        }
//    }
//
//}
