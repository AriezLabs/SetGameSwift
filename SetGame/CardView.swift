//
//  CardView.swift
//  SetGame
//
//  Created by ariez on 14.07.20.
//  Copyright © 2020 AriezLabs. All rights reserved.
//

import SwiftUI

struct CardView: View {
    let appearance: ViewModel.CardAppearance
    
    let cornerRadius: CGFloat = 0.05
    let outerPaddingPerc: CGFloat = 0.1
    let elementPaddingPerc: CGFloat = 0.01
    let aspectRatio: CGFloat = 2/3
    var lineWidth: CGFloat = 0.015
    
    var borderColor: Color {
        if appearance.card.matched {
            return .green
        } else if appearance.card.inUnmatchingTrio {
            return .red
        } else {
            return .init(white: 0.3)
        }
    }
    
    var fillOpacity: Double {
        self.appearance.card.selected ? 0.15 : 0
    }
    
    @ViewBuilder
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: geometry.size.height * self.cornerRadius)
                    .foregroundColor(.white)
                
                RoundedRectangle(cornerRadius: geometry.size.height * self.cornerRadius)
                    .foregroundColor(.black)
                    .opacity(self.fillOpacity)
                
                RoundedRectangle(cornerRadius: geometry.size.height * self.cornerRadius)
                    .stroke(lineWidth: geometry.size.height * self.lineWidth)
                    .foregroundColor(self.borderColor)
                
                VStack {
                    ForEach(Range(0 ... self.appearance.number)) { _ in
                        self.appearance.shape
                            .padding(geometry.size.height * self.elementPaddingPerc)
                    }
                }
                .padding(geometry.size.height * self.outerPaddingPerc)
            }
            .aspectRatio(self.aspectRatio, contentMode: .fit)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(appearance: ViewModel.CardAppearance(for: SetModel.Card(id: 66), in: ViewModel()))
    }
}
