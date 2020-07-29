//
//  ViewModel.swift
//  SetGame
//
//  Created by ariez on 14.07.20.
//  Copyright © 2020 AriezLabs. All rights reserved.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published private var model = SetModel()
    
    // MARK: Model access
    
    var dealtCards: Array<SetModel.Card> {
        return model.dealtCards.filter() { card in
            card.inDeck
        }
    }
    
    var nSelectedCards: Int { model.nSelectedCards }
    
    var nCardsLeft: Int { model.cards.count }
    
    var score: Int { model.score }
    
    // MARK: Intents
    
    func deal() {
        model.deal()
    }
    
    func select(_ card: SetModel.Card) {
        model.select(card)
    }
    
    func matchSet() {
        let _ = model.matchSet()
    }
    
    func restart() {
        model.restart()
    }
    
    func cheat() {
        model.cheat()
    }
    
    // MARK: IDK where this should go, prolly in sth like Cardify
    
    struct CardAppearance {
        let card: SetModel.Card
        let model: ViewModel
        
        init(for card: SetModel.Card, in model: ViewModel) {
            self.card = card
            self.model = model
        }
        
        var borderColor: Color {
            if card.matched {
                return .green
            } else if card.inUnmatchingTrio {
                return .red
            } else {
                return .init(white: 0.3)
            }
        }
        
        var number: Int {
            return card.number.rawValue
        }
        
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
    }
    
}
