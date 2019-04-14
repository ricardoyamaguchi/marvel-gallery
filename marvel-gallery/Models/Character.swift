//
//  Character.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 08/02/19.
//  Copyright © 2019 Ricardo Yamaguchi. All rights reserved.
//

import Foundation

struct Character: Codable {
    let id: Int
    let name, description: String?
    let modified:  String?
    let thumbnail: Thumbnail?
    let resourceURI: String?
    let comics, series: Comics?
    let stories: Stories?
    let events: Comics?
    let urls: [URLElement]?
}
