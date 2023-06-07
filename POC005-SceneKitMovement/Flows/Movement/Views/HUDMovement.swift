//
//  HUDMovement.swift
//  POC005-SceneKitMovement
//
//  Created by Luiz Araujo on 06/06/23.
//

import SwiftUI

struct HUDMovement: View {
    
    @Binding var count: Int
    
    var body: some View {
        VStack {
            HStack {
                Text("\(count)")
                    .font(.system(.largeTitle, design: .rounded, weight: .black))
                Text("/100")
                    .font(.system(.title, design: .rounded, weight: .heavy))
            }
            .foregroundColor(.white)
            
            Spacer()
        }
    }
}

struct HUDMovement_Previews: PreviewProvider {
    static var previews: some View {
        HUDMovement(count: .constant(10))
    }
}
