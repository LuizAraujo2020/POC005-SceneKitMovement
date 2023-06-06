//
//  Helpers.swift
//  POC005-SceneKitMovement
//
//  Created by Luiz Araujo on 05/06/23.
//

// 2 * pi = 360°
// =>
// pi = 180°
// =>
// pi/180 = 1°
// =>
// 0,01745329252 = 1°
func getRadianFor(degree: Float) -> Float {
    return Float(Double.pi/180) * degree
}

