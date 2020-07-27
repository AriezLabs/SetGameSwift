//
//  ContentView.swift
//  SetGame
//
//  Created by ariez on 13.07.20.
//  Copyright © 2020 AriezLabs. All rights reserved.
//

import SwiftUI

struct SetView: View {
    @ObservedObject var model: ViewModel
    
    let paddingPerc: CGFloat = 0.005
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Grid(self.model.dealtCards) { card in
                    CardView(appearance: ViewModel.CardAppearance(for: card, in: self.model))
                        .padding(geometry.size.height * self.paddingPerc)
                        .transition(AnyTransition.scale.animation(.easeInOut(duration: 0.2)))
                        .onTapGesture {
                            withAnimation(Animation.easeInOut(duration: 0.2)) {
                                self.model.select(card)
                            }
                            
                            withAnimation(Animation.easeInOut(duration: 0.01).delay(0.15).repeatCount(7)) {
                                self.model.matchSet()
                            }
                        }
                }
                
                Button("Deal") {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        self.model.deal()
                    }
                }
            }
        }
    }
}

struct SetView_Previews: PreviewProvider {
    static var previews: some View {
        let model = ViewModel()
        model.deal()
        return SetView(model: model)
    }
}
