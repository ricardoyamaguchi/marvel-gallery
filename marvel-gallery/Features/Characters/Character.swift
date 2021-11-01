//
//  Character.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 16/10/21.
//

import Foundation

// MARK: - Character

struct Character: Codable, Hashable {

    let characterId: Int?
    let name, resultDescription, modified: String?
    let resourceURI: String?
    let urls: [URLElement]?
    let thumbnail: Thumbnail?
    let comics: Related?
    let stories: Stories?
    let events, series: Related?

    enum CodingKeys: String, CodingKey {
        case characterId = "id"
        case name
        case resultDescription = "description"
        case modified, resourceURI, urls, thumbnail, comics, stories, events, series
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(characterId)
    }

    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.characterId == rhs.characterId
    }

}
