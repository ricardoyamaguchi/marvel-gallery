//
//  CharactersService.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 16/10/21.
//

import Foundation

protocol CharacterServiceProtocol {
    func fetchCharactersList(page: Int, limit: Int, completion: @escaping Completion<Character>)

}

class CharactersService: BaseService, CharacterServiceProtocol {

    func fetchCharactersList(page: Int, limit: Int, completion: @escaping Completion<Character>) {
        let params = [
            URLQueryItem(name: "offset", value: "\(page)"),
            URLQueryItem(name: "limit", value: "\(limit)")
        ]
        connection.request(method: .get, endpoint: CharactersURL.characters, params: params, completion: completion)
    }

}

struct CharactersURL {

    static let characters = "/characters"

}
