//
//  CharactersProvider.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 04/02/19.
//  Copyright © 2019 Ricardo Yamaguchi. All rights reserved.
//

import Foundation

class CharactersProvider: BaseProvider<Character> {
    
    override var endPoint: String {
        return "/v1/public/characters"
    }
    
}
