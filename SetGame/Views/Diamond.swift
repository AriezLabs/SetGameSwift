//
//  Diamond.swift
//  SetGame
//
//  Created by ariez on 15.07.20.
//  Copyright © 2020 AriezLabs. All rights reserved.
//

import SwiftUI

struct Diamond: View {
    let color: Color
    let fillOpacity: Double
    
    @ViewBuilder
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .stroke(lineWidth: Constants.outlineWidth(for: geometry))
                    .rotation(Angle(degrees: 45))
                    .scale(1/sqrt(2))
                    .fill(self.color)
                    .aspectRatio(1, contentMode: .fit)
                
                Rectangle()
                    .rotation(Angle(degrees: 45))
                    .scale(1/sqrt(2))
                    .fill(self.color)
                    .aspectRatio(1, contentMode: .fit)
                    .opacity(self.fillOpacity)
            }
        }
    }
}

struct Diamond_Previews: PreviewProvider {
    static var previews: some View {
        Diamond(color: .green, fillOpacity: 0.5)
    }
}
