//
//  Character.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 16/10/21.
//

import Foundation

// MARK: - Character

struct Character: Codable, Hashable {

    let id: Int?
    let name, resultDescription, modified: String?
    let resourceURI: String?
    let urls: [URLElement]?
    let thumbnail: Thumbnail?
    let comics: CharacterComics?
    let stories: Stories?
    let events, series: CharacterComics?

    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case modified, resourceURI, urls, thumbnail, comics, stories, events, series
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id
    }

}

// MARK: - Comics

struct CharacterComics: Codable {
    let collectionURI: String?
    let available, returned: Int?
    let items: [CharacterComicsItem]?
}

// MARK: - ComicsItem

struct CharacterComicsItem: Codable {
    let resourceURI, name: String?
}
