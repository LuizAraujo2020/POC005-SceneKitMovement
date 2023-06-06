//
//  Router.swift
//  POC02
//
//  Created by Luiz Araujo on 22/05/23.
//

import SwiftUI

class Router: ObservableObject {
    @Published var path = NavigationPath()
    
    func reset() {
        path = NavigationPath()
    }
}
