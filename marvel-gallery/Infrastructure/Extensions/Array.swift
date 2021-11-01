//
//  Array.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 18/10/21.
//

import Foundation

extension Array where Element: Equatable {
    func isLast(element: Element) -> Bool {
        last == element
    }
}
