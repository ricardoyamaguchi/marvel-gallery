//
//  Font.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 14/10/21.
//

import SwiftUI

extension Font {

    // MARK: - Heebo

    static func heeboBlack(size: CGFloat) -> Font { .custom("Heebo-Black", size: size) }
    static func heeboBold(size: CGFloat) -> Font { .custom("Heebo-Bold", size: size) }
    static func heeboExtraBold(size: CGFloat) -> Font { .custom("Heebo-ExtraBold", size: size) }
    static func heeboLight(size: CGFloat) -> Font { .custom("Heebo-Light", size: size) }
    static func heeboMedium(size: CGFloat) -> Font { .custom("Heebo-Medium", size: size) }
    static func heeboRegular(size: CGFloat) -> Font { .custom("Heebo-Regular", size: size) }
    static func heeboThin(size: CGFloat) -> Font { .custom("Heebo-Thin", size: size) }

    // MARK: - Marvel

    static func marvelRegular(size: CGFloat) -> Font { .custom("Marvel-Regular", size: size) }

}
