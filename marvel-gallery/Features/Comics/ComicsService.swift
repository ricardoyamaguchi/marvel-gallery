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

class ComicsService: BaseService, ComicsServiceProtocol {

    func fetchComicsList(characterId: String, page: Int, limit: Int,
                         completion: @escaping Completion<Comic>) {
        let params = [
            URLQueryItem(name: "characters", value: characterId)
        ]

        connection.request(
            method: .get,
            endpoint: ComicsURL.comics,
            params: params,
            completion: completion
        )
    }

}

struct ComicsURL {

    static let comics = "/comics"

}
