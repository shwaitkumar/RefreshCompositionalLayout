//
//  Item2.swift
//  RefreshCompositionalLayout
//
//  Created by WorksDelight on 07/06/23.
//

import Foundation

struct Item2: Hashable {
    let text: String

    static func == (lhs: Item2, rhs: Item2) -> Bool {
        return lhs.text == rhs.text
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(text)
    }
}
