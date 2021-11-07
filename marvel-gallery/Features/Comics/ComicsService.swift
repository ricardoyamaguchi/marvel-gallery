//
//  ComicsService.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 31/10/21.
//

import Foundation

protocol ComicsServiceProtocol {
    func fetchComicsList(characterId: String, page: Int, limit: Int,
                         completion: @escaping Completion<Comic>)
}

class ComicsService: ComicsServiceProtocol {

    func fetchComicsList(characterId: String, page: Int, limit: Int,
                         completion: @escaping Completion<Comic>) {
        var params = [
            URLQueryItem(name: "", value: characterId)
        ]
    }

}

struct ComicsURL {

    static let comics = "/comics"

}
