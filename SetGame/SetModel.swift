//
//  SetGame.swift
//  SetGame
//
//  Created by ariez on 13.07.20.
//  Copyright © 2020 AriezLabs. All rights reserved.
//

import Foundation

struct SetModel {
    
    private(set) var cards: [Card] = {
        var cards = Array<Card>()
        for i in 0 ..< 81 {
            cards.append(Card(id: i))
        }
        return cards.shuffled()
    }()
    
    private(set) var dealtCards: [Card] = Array<Card>()
    
    /// Move dealt cards back to deck and reshuffle
    mutating func restart() {
        for _ in 0 ..< dealtCards.count {
            cards.append(dealtCards.removeFirst())
        }
        cards.shuffle()
    }
    
    /// Deal out 12 cards if none have been dealt yet or else deal 3 more.
    mutating func deal() {
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
    
    /// True iff the cards have either all the same or all different shape, color, number and shading.
    func isSet(_ c1: Card, _ c2: Card, _ c3: Card) -> Bool {
        func checkForProperty(property: (Card) -> Int) -> Bool {
            let nUniqueValues = Set([property(c1), property(c2), property(c3)]).count
            return nUniqueValues != 2
        }
        
        return checkForProperty() { $0.number.rawValue } &&
               checkForProperty() { $0.color.rawValue } &&
               checkForProperty() { $0.shape.rawValue } &&
               checkForProperty() { $0.shading.rawValue }
    }
    
    /// If a set was correctly identified, remove it from the dealt cards. Do nothing if one or more cards aren't among those dealt. Return true upon success.
    mutating func callSet(_ c1: Card, _ c2: Card, _ c3: Card) -> Bool {
        if isSet(c1, c2, c3) {
            if let i1 = dealtCards.firstIndex(matching: c1), let i2 = dealtCards.firstIndex(matching: c2), let i3 = dealtCards.firstIndex(matching: c3) {
                let order = [i1, i2, i3].sorted().reversed()
                for i in order {
                    dealtCards.remove(at: i)
                }
                return true
            }
        }
        return false
    }
    
    struct Card: CustomStringConvertible, Identifiable {
        let id: String
        
        init(id: Int) {
            var paddedId = String(id, radix: 3)
            while paddedId.count < 4 {
                paddedId = "0" + paddedId
            }
            self.id = paddedId
            
            print(self.number.rawValue)
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
