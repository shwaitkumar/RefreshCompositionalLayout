//
//  Item1.swift
//  RefreshCompositionalLayout
//
//  Created by WorksDelight on 07/06/23.
//

import Foundation

struct Item1: Hashable {
    let text: String
    var number: Int

    static func == (lhs: Item1, rhs: Item1) -> Bool {
        return lhs.text == rhs.text &&
        lhs.number == rhs.number
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(text)
        hasher.combine(number)
    }
}
