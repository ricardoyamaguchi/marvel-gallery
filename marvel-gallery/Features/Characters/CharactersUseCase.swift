//
//  CharactersUseCase.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 17/10/21.
//

import Foundation

typealias CharactersUseCaseCompletion = ((CharactersUseCaseResponse) -> Void)

enum CharactersUseCaseResponse {
    case success([Character]?)
    case failure(CharactersUseCaseError)
}

enum CharactersUseCaseError {
    case generic
}

protocol CharactersUseCaseProtocol {
    func fetchCharactersList(nameStartsWith: String?, page: Int, limit: Int, completion: @escaping CharactersUseCaseCompletion)
}

struct CharactersUseCase: CharactersUseCaseProtocol {

    private var service: CharacterServiceProtocol

    init(service: CharacterServiceProtocol = CharactersService()) {
        self.service = service
    }

    func fetchCharactersList(nameStartsWith: String?, page: Int, limit: Int, completion: @escaping CharactersUseCaseCompletion) {
        service.fetchCharactersList(nameStartsWith: nameStartsWith, page: page, limit: limit) { result in
            switch result {
            case .success(let list):
                completion(.success(list))
            case .failure( let error ):
                guard
                    let error = error else {
                        completion(.failure(.generic))
                        return
                    }

                completion(.failure(.generic))
            }
        }
    }

}
