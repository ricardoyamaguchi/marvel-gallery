//
//  MarvelResponse.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 07/02/19.
//  Copyright © 2019 Ricardo Yamaguchi. All rights reserved.
//
// To parse the JSON, add this file to your project and do:
//
// let marvelResponse = try? newJSONDecoder().decode(MarvelResponse.self, from: jsonData)

import Foundation

struct MarvelResponse<T: Codable>: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: DataClass<T>?
}

struct DataClass<T: Codable>: Codable {
    let offset, limit, total, count: Int?
    let results: [T]?
}

struct Thumbnail: Codable {
    let path: String?
    let type: ImageType?
    enum CodingKeys: String, CodingKey {
        case path
        case type = "extension"
    }
}

struct URLElement: Codable {
    let type: String?
    let url: String?
}
