//
//  Color.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 14/10/21.
//

import SwiftUI

extension Color {

    static func hex(_ hex: String, alpha: Double = 1.0) -> Color {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        return Color(
            .sRGB,
            red: Double((rgbValue >> 16) & 0xff) / 255,
            green: Double((rgbValue >> 08) & 0xff) / 255,
            blue: Double((rgbValue >> 00) & 0xff) / 255,
            opacity: alpha)
    }

}

extension Color {

    static let eerieBlack: Color = { Color.hex("212121") }()
    static let jet: Color = { Color.hex("393939") }()
    static let cultured: Color = { Color.hex("EDEDED") }()
    static let redPigment: Color = { Color.hex("EC1D24") }()

}
