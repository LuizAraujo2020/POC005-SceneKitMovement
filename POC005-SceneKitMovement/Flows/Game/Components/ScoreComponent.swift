//
//  ScoreComponent.swift
//  ECSPractice01
//
//  Created by Luiz Araujo on 18/05/23.
//

import GameplayKit
import SceneKit

class ScoreComponent: GKComponent {
    
    private(set) var score: Double = 0.0
    
    func increase(_ point: Double = 1.0) {
        score += point
        if score < 0 {
            score = 0
        }
    }
    
    func decrease(_ point: Double = 1.0) {
        score -= point
        if score < 0 {
            score = 0
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
