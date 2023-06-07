//
//  POC005_SceneKitMovementApp.swift
//  POC005-SceneKitMovement
//
//  Created by Luiz Araujo on 04/06/23.
//

import SwiftUI
import SceneKit

@main
struct POC005_SceneKitMovementApp: App {
    var body: some Scene {
        WindowGroup {
//            ContentView()
            MovementView(game: GameMovement())
        }
    }
}
