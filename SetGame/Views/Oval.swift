//
//  Oval.swift
//  SetGame
//
//  Created by ariez on 15.07.20.
//  Copyright © 2020 AriezLabs. All rights reserved.
//

import SwiftUI

struct Oval: View {
    let color: Color
    let fillOpacity: Double
    
    @ViewBuilder
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Capsule()
                    .stroke(lineWidth: Constants.outlineWidth(for: geometry))
                    .fill(self.color)
                    .aspectRatio(2.5, contentMode: .fit)
                
                Capsule()
                    .fill(self.color)
                    .opacity(self.fillOpacity)
                    .aspectRatio(2.5, contentMode: .fit)
            }
        }
    }
}

struct Oval_Previews: PreviewProvider {
    static var previews: some View {
        Oval(color: .green, fillOpacity: 0.5)
    }
}
