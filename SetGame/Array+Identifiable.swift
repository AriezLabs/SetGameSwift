//
//  File.swift
//  Memorize
//
//  Created by ariez on 23.06.20.
//  Copyright © 2020 AriezLabs. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    mutating func removeFirst(matching el: Element) -> Element? {
        if let index = firstIndex(matching: el) {
            return self.remove(at: index)
        }
        return nil
    }
    
    func firstIndex(matching: Element) -> Int? {
        for i in 0 ..< self.count {
            if self[i].id == matching.id {
                return i
            }
        }
        return nil
    }
}
