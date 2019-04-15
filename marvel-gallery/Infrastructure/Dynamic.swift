//
//  Dynamic.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 14/04/19.
//  Copyright © 2019 Ricardo Yamaguchi. All rights reserved.
//

import Foundation

class Dynamic<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    func bind(listener: @escaping Listener) {
        self.listener = listener
    }
    
    init(_ defaultValue: T) {
        value = defaultValue
    }
    
}
