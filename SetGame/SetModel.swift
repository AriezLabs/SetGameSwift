//
//  SetGame.swift
//  SetGame
//
//  Created by ariez on 13.07.20.
//  Copyright © 2020 AriezLabs. All rights reserved.
//

import Foundation

struct SetModel {
    
    private(set) var cards: [Card]
    
    private(set) var dealtCards: [Card] = Array<Card>()
    
    private(set) var score: Int = 0
    
    init() {
        var cards = Array<Card>()
        for i in 0 ..< 81 {
            cards.append(Card(id: i))
        }
        self.cards = cards.shuffled()
    }
    
    /// O(n)?
    var selectedCards: [Card] {
        return dealtCards.filter() { $0.selected }
    }
    
    /// O(n)?
    var nSelectedCards: Int {
        return dealtCards.filter({ $0.selected }).count
    }
    
    /// Move dealt cards back to deck and reshuffle
    mutating func restart() {
        for _ in 0 ..< dealtCards.count {
            cards.append(dealtCards.removeFirst())
        }
        cards.shuffle()
    }
    
    /// Deal out 12 cards if none have been dealt yet or else deal 3 more. Also take a set if selected.
    mutating func deal() {
        takeSet()
        
        var i: Int
        if dealtCards.count == 0 {
            i = 12
        } else {
            i = 3
        }
        for _ in 0 ..< i {
            dealtCards.append(cards.removeFirst())
        }
    }
    
    func selectedCardsMatch() -> Bool {
        if nSelectedCards == 3 {

            func checkForProperty(_ toProperty: (Card) -> Int) -> Bool {
                let nUniqueValues = Set(selectedCards.map(toProperty)).count
                return nUniqueValues != 2
            }
            
            return checkForProperty({ $0.number.rawValue }) &&
                checkForProperty({ $0.color.rawValue }) &&
                checkForProperty({ $0.shape.rawValue }) &&
                checkForProperty({ $0.shading.rawValue })
        }
        
        return false
    }
    
    /// Removes a matching set from deck.
    mutating func takeSet() {
        if nSelectedCards == 3 {
            if selectedCardsMatch() {
                selectedCards.forEach() {
                    dealtCards[dealtCards.firstIndex(matching: $0)!].inDeck = false
                }
                score += 1
            }
            
            selectedCards.forEach() {
                dealtCards[dealtCards.firstIndex(matching: $0)!].selected = false
            }
        }
    }
    
    /// Sets Card.matched to true if a set has been chosen.
    mutating func matchSet() {
        // Check if it's a set
        if nSelectedCards == 3 {
            if selectedCardsMatch() {
                selectedCards.forEach() {
                    dealtCards[dealtCards.firstIndex(matching: $0)!].matched = true
                }
            } else {
                selectedCards.forEach() {
                    dealtCards[dealtCards.firstIndex(matching: $0)!].inUnmatchingTrio = true
                }
            }
        }
    }
    
    /// Remove a previously selected set if present. Select card. Perform set matching.
    mutating func select(_ c: Card) {
        // Select (or deselect) new card
        if let idx = dealtCards.firstIndex(matching: c), dealtCards[idx].inDeck {

            if nSelectedCards < 3 {
                dealtCards[idx].selected = !dealtCards[idx].selected
            
            } else if nSelectedCards == 3 {
                
                if selectedCardsMatch() {
                    takeSet()
                    
                } else {
                    selectedCards.forEach() {
                        dealtCards[dealtCards.firstIndex(matching: $0)!].selected = false
                    }
                    dealtCards[idx].selected = !dealtCards[idx].selected
                }
            }
        }
    }
    
    struct Card: CustomStringConvertible, Identifiable {
        let id: String
        
        var matched: Bool = false
        var inUnmatchingTrio: Bool = false // True iff this card is one of 3 selected and they don't match
        var inDeck: Bool = true
        var selected: Bool = false {
            didSet {
                if selected == false {
                    inUnmatchingTrio = false
                }
            }
        }
        
        // ID is a 4 digit, base 3 number representing a card.
        // For example, id 0201 means: striped (1) diamond (0) green (2) one (0)
        init(id: Int) {
            var paddedId = String(id, radix: 3)
            while paddedId.count < 4 {
                paddedId = "0" + paddedId
            }
            self.id = paddedId
        }
        
        var description: String {
            return "(\(id): \(number) \(color) \(shape) \(shading))"
        }
        
        var number: Number {
            Number(rawValue: Int(String(id[0]))!)!
        }
        
        var color: Color {
            Color(rawValue: Int(String(id[1]))!)!
        }
        
        var shape: Shape {
            Shape(rawValue: Int(String(id[2]))!)!
        }
        
        var shading: Shading {
            Shading(rawValue: Int(String(id[3]))!)!
        }
        
        enum Number: Int {
            case one, two, three
        }
        
        enum Color: Int {
            case red, blue, green
        }
        
        enum Shape: Int {
            case diamond, squiggle, oval
        }
        
        enum Shading: Int {
            case blank, stripes, solid
        }
    }
}
