//
//  L10n.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 15/10/21.
//

import Foundation

enum L10n: String {

    // MARK: - Commons

    case comicsLabel,
         descriptionLabel,
         detailsLabel,
         detailsUnavailable,
         nameLabel,
         okLabel

    // MARK: - Main Page

    case mainPageTitle

    // MARK: - Characters

    case charactersTitle,
         charactersMessage,
         charactersEmptyState,
         charactersSearchPlaceholder,
         charactersSearchLabel

    // MARK: - Character Detail

    case characterDetailsAbout

    // MARK: - Comics

    case comicsTitle

    var text: String { NSLocalizedString(rawValue, comment: "") }
}
