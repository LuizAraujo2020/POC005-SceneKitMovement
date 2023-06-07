import SceneKit

final class FloorNode: SCNNode {

    override init() {
        super.init()

        // infinite floor
        let floorGeometry = SCNFloor()
        floorGeometry.firstMaterial?.diffuse.contents = UIImage(named: "catalog.scnassets/grass.jpg")
        floorGeometry.firstMaterial?.diffuse.wrapS = .repeat
        floorGeometry.firstMaterial?.diffuse.wrapT = .repeat

        // the higher the number the more often the repetition (the smaller the image get)
        floorGeometry.firstMaterial?.diffuse.contentsTransform = SCNMatrix4MakeScale(25, 25, 25)

        let floorShape = SCNPhysicsShape(geometry: floorGeometry, options: nil)
        let floorBody = SCNPhysicsBody(type: .kinematic, shape: floorShape)
        floorBody.categoryBitMask = PhysicsCategories.ground.rawValue
        floorBody.collisionBitMask = PhysicsCategories.player.rawValue | PhysicsCategories.mob.rawValue
        floorBody.contactTestBitMask = PhysicsCategories.player.rawValue | PhysicsCategories.mob.rawValue
        
        physicsBody = floorBody
        geometry = floorGeometry
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
