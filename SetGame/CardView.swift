//
//  CardView.swift
//  SetGame
//
//  Created by ariez on 14.07.20.
//  Copyright © 2020 AriezLabs. All rights reserved.
//

import SwiftUI

struct CardView: View {
    let card: SetModel.Card
    
    var shape: some View {
        switch card.shape {
            case .diamond:
                return AnyView(Diamond(color: self.color, fillOpacity: self.fill))
            case .squiggle:
                return AnyView(Squiggle(color: self.color, fillOpacity: self.fill))
            case .oval:
                return AnyView(Oval(color: self.color, fillOpacity: self.fill))
        }
    }
    
    var fill: Double {
        switch card.shading {
            case .blank:
                return 0
            case .stripes:
                return 0.5
            case .solid:
                return 1
        }
    }
    
    var color: Color {
        switch card.color {
            case .blue:
                return .blue
            case .red:
                return .red
            case .green:
                return .green
        }
    }
    
    @ViewBuilder
    var body: some View {
        VStack {
            ForEach(Range(0 ... card.number.rawValue)) { _ in
                self.shape
                    .padding()
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: SetModel.Card(id: 67))
    }
}
