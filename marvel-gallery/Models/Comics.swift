//
//  Comics.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 08/02/19.
//  Copyright © 2019 Ricardo Yamaguchi. All rights reserved.
//

import Foundation

struct Comics: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [ComicsItem]?
    let returned: Int?
}

struct ComicsItem: Codable {
    let resourceURI: String?
    let name: String?
}
