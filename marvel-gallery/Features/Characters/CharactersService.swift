//
//  CharactersService.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 16/10/21.
//

import Foundation

protocol CharacterServiceProtocol {
    func fetchCharactersList(nameStartsWith: String?, page: Int, limit: Int, completion: @escaping Completion<Character>)

}

class CharactersService: BaseService, CharacterServiceProtocol {

    func fetchCharactersList(nameStartsWith: String?, page: Int, limit: Int, completion: @escaping Completion<Character>) {
        var params = [
            URLQueryItem(name: "offset", value: "\(page)"),
            URLQueryItem(name: "limit", value: "\(limit)")
        ]
        if let nameStartsWith = nameStartsWith {
            params.append(URLQueryItem(name: "nameStartsWith", value: nameStartsWith))
        }
        connection.request(method: .get, endpoint: CharactersURL.characters, params: params, completion: completion)
    }

}

struct CharactersURL {

    static let characters = "/characters"

}
