//
//  CharactersViewModel.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 16/10/21.
//

import Foundation

protocol CharactersViewModelProtocol: ObservableObject {
    var characters: [Character] { get set }
    var error: CharactersUseCaseError? { get set }
    var loading: Bool { get set }
    func fetchCharactersIfNeeded(currentCharacter: Character)
    func fetchCharactersList(name: String?)

}

class CharactersViewModel: CharactersViewModelProtocol {

    private let kPageSize = 12
    private var useCase: CharactersUseCaseProtocol
    private var lastLoadedPage = 0

    @Published var characters: [Character] = []
    @Published var error: CharactersUseCaseError?
    @Published var loading = false

    init(useCase: CharactersUseCaseProtocol = CharactersUseCase()) {
        self.useCase = useCase
    }

    func fetchCharactersIfNeeded(currentCharacter: Character) {
        if !characters.isLast(element: currentCharacter) || loading {
            return
        }
        fetchCharactersList()
    }

    func fetchCharactersList(name: String? = nil) {
        loading = true

        useCase.fetchCharactersList(nameStartsWith: name,
                                    page: lastLoadedPage * kPageSize,
                                    limit: kPageSize) { [weak self] result in
            self?.loading = false
            switch result {
            case .success(let characters): self?.handleSuccess(characters)
            case .failure(let error): self?.error = error
            }
        }

        lastLoadedPage += 1

    }

    func handleSuccess(_ characters: [Character]?) {
        guard let characters = characters else { return }
        self.characters.append(contentsOf: characters)
    }

}
