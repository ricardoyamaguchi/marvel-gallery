//
//  Comic.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 31/10/21.
//

import Foundation

// MARK: - Comic

struct Comic: Codable {
    let comicId, digitalID, title, issueNumber: String
    let variantDescription, resultDescription, modified, isbn: String
    let upc, diamondCode, ean, issn: String
    let format, pageCount: String
    let textObjects: [TextObject]
    let resourceURI: String
    let urls: [URLElement]
    let series: Item
    let variants, collections, collectedIssues: [Item]
    let dates: [DateElement]
    let prices: [Price]
    let thumbnail: Thumbnail
    let images: [Thumbnail]
    let creators, characters: Related
    let stories: Stories
    let events: Related

    enum CodingKeys: String, CodingKey {
        case comicId = "id"
        case digitalID = "digitalId"
        case title, issueNumber, variantDescription
        case resultDescription = "description"
        case modified, isbn, upc, diamondCode, ean, issn,
             format, pageCount, textObjects, resourceURI,
             urls, series, variants, collections, collectedIssues,
             dates, prices, thumbnail, images, creators, characters,
             stories, events
    }
}

// MARK: - Price

struct Price: Codable {
    let type, price: String
}
