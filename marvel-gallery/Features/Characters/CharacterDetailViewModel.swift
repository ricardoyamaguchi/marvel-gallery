//
//  CharacterDetailViewModel.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 18/10/21.
//

import Foundation

class CharacterDetailViewModel: ObservableObject {

    private var character: Character

    init(character: Character) {
        self.character = character
    }

    func getCharacterName() -> String {
        return (character.name ?? L10n.detailsLabel.text).uppercased()
    }

    func getCharacterThumbnailPath() -> String {
        return character.thumbnail?.path ?? ""
    }

    func getCharacterDescription() -> String {
        guard
            let description = character.resultDescription else {
                return L10n.detailsUnavailable.text
            }

        return description.isEmpty ? L10n.detailsUnavailable.text : description
    }

}
