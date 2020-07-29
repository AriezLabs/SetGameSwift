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
    
    func dealAnimated() {
        withAnimation(.easeInOut) {
            self.model.deal()
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Button("New game") {
                        withAnimation(Animation.easeInOut) {
                            self.model.restart()
                        }
                        self.dealAnimated()
                    }.padding()
                    
                    Spacer()
                    
                    Text("Score: \(self.model.score)")
                        .bold()
                    
                    Spacer()
                    
                    Button("Cheat") {
                        withAnimation(Animation.easeInOut) {
                            self.model.cheat()
                        }
                    }.padding()
                }
                
                Grid(self.model.dealtCards) { card, index, layout in
                    CardView(appearance: ViewModel.CardAppearance(for: card, in: self.model))
                        .padding(geometry.size.height * self.paddingPerc)
                        .transition(
                            card.matched ?
                                AnyTransition.offset(x: -layout.location(ofItemAt: index).x + geometry.size.width, y: -layout.location(ofItemAt: index).y + geometry.size.height)
                            :   AnyTransition.offset(x: -layout.location(ofItemAt: index).x - 30, y: -layout.location(ofItemAt: index).y - 50)
                        )
                        .onTapGesture {
                            withAnimation(Animation.easeInOut(duration: 0.2)) {
                                self.model.select(card)
                            }
                            
                            withAnimation(Animation.easeInOut(duration: 0.01).delay(0.15).repeatCount(7)) {
                                self.model.matchSet()
                            }
                        }
                }
                .onAppear() {
                    self.dealAnimated()
                }
                
                Spacer(minLength: 10)
                
                Button("Deal") {
                    self.dealAnimated()
                }.disabled(self.model.nCardsLeft == 0)
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
