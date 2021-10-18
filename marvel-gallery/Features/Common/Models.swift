//
//  Models.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 16/10/21.
//

import Foundation

// MARK: - Response

struct Response<T: Codable>: Codable {
    let status, copyright, attributionText: String?
    let code: Int?
    let attributionHTML: String?
    let data: DataClass<T>?
    let etag: String?
}

// MARK: - DataClass

struct DataClass<T: Codable>: Codable {
    let offset, limit, total, count: Int?
    let results: [T]?
}

// MARK: - URLElement

struct URLElement: Codable {
    let type, url: String?
}

// MARK: - Thumbnail

struct Thumbnail: Codable {
    let path, thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - Stories

struct Stories: Codable {
    let collectionURI: String?
    let available, returned: Int?
    let items: [StoriesItem]?
}

// MARK: - StoriesItem

struct StoriesItem: Codable {
    let resourceURI, name, type: String?
}

// MARK: - TextObject

struct TextObject: Codable {
    let type, language, text: String?
}
