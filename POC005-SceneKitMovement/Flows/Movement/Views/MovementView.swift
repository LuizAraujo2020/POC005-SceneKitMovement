//
//  MovementView.swift
//  POC005-SceneKitMovement
//
//  Created by Luiz Araujo on 04/06/23.
//

import SwiftUI
import UIKit
import SceneKit
import SpriteKit

struct MovementView: View {
    
    @State private var magnification    = CGFloat(1.0)
    @State private var totalChangePivot = SCNMatrix4Identity
    
    @ObservedObject var game: Movement
    
    init(game: Movement) {
        self.game = game
    }
    
    var body: some View {
        ZStack {
            SpriteView(scene: game.skScene)
            VStack {
                SceneView(scene: game.scene,
                          pointOfView: game.cameraNode,
                          options: [
                            .rendersContinuously
                          ], delegate: game)
                .ignoresSafeArea()
                .gesture(exclusiveGesture)
            }
            
        }
    }
    
    // Don't forget to comment this is you are using .allowsCameraControl
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.game.isDragging = true
                
                if game.virtualDPad().contains(value.location) {
                    let middleOfCircleX = game.virtualDPad().origin.x + 75
                    let middleOfCircleY = game.virtualDPad().origin.y + 75
                    
                    let lengthOfX = Double(value.location.x - middleOfCircleX)
                    let lengthOfY = Double(value.location.y - middleOfCircleY)
                    
                    game.direction = normalize(SIMD2(x: lengthOfX, y: lengthOfY))
                    
                    let degree = atan2(game.direction.x, game.direction.y)
                    game.playerNode.directionAngle = SCNFloat(degree)
                }
            }
            .onEnded { value in
                self.game.isDragging = false
            }
    }
    
    // Don't forget to comment this is you are using .allowsCameraControl
    var magnify: some Gesture {
        MagnificationGesture()
            .onChanged{ (value) in
                print("magnify = \(self.magnification)")
                
                self.magnification = value
                
                changeCameraFOV(of: game.cameraNode.camera!,
                                value: self.magnification)
            }
            .onEnded{ value in
                print("Ended pinch with value \(value)\n\n")
            }
    }
    
    // Don't forget to comment this is you are using .allowsCameraControl
    var exclusiveGesture: some Gesture {
        ExclusiveGesture(drag, magnify)
    }
    
    private func changeCameraFOV(of camera: SCNCamera, value: CGFloat) {
        if self.magnification >= 1.025 {
            self.magnification = 1.025
        }
        if self.magnification <= 0.97 {
            self.magnification = 0.97
        }
        
        let maximumFOV: CGFloat = 25 // Zoom-in.
        let minimumFOV: CGFloat = 90 // Zoom-out.
        
        camera.fieldOfView /= magnification
        
        if camera.fieldOfView <= maximumFOV {
            camera.fieldOfView = maximumFOV
            self.magnification = 1.0
        }
        
        if camera.fieldOfView >= minimumFOV {
            camera.fieldOfView = minimumFOV
            self.magnification = 1.0
        }
    }
}


struct MovementView_Previews: PreviewProvider {
    static var previews: some View {
        MovementView(game: Movement())
    }
}
