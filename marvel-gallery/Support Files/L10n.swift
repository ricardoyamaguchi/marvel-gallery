//
//  L10n.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 15/10/21.
//

import Foundation

enum L10n: String {

    // MARK: - Commons

    case detailsLabel,
         detailsUnavailable

    // MARK: - Main Page

    case mainPageTitle

    // MARK: - Characters

    case charactersTitle,
         charactersMessage

    case characterDetailsAbout

    var text: String { NSLocalizedString(rawValue, comment: "") }
    
}
